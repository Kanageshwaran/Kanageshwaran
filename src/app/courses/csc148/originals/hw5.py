"""
Name: Kanageshwaran Dhakshinamoorthy
Course: CSC 148 - Programming with SimPy (Fall 2025)
Instructor: Prof. Mitchell
Assignment: Homework 5 - MI Model with Restocking
Date: December 2025

Description:
  This script extends the Homework-4 MI model to include restocking.
  Ten Contractor-Only sites (CO1-CO10) execute sales. When inventory
  drops below RP = 100, the CO interrupts the Warehouse. The Warehouse
  schedules restocking via a shared event. If a sale would cause a
  stockout, the CO suspends until the restock completes.

  Required message sequences:
    • CO creation messages
    • doOrders() starts
    • Sales with I(t)
    • III messages
    • SSS (stockout)
    • CRAS / CNS (restock result)
    • RRR reports every 10 time units

  Runs until model time 49.
"""

import simpy
import random
import sys
import matplotlib.pyplot as plt

# Instructor directory
sys.path.append('/home/college/mitchell/simpy3demos')
import linePlot as lp

# ---- Global ----
randomSeed = 1234567890
random.seed(randomSeed)
RP = 100
SIM_END_TIME = 49

# To ensure the CO5/CO6 header prints only once
printed_deferred_header = False


# ==========================================================
# Warehouse Class
# ==========================================================
class Warehouse:

    def __init__(self, env, name):
        self.env = env
        self.name = name

        self.co_dict = {}
        self.se_dict = {}

        self.stockoutCounts = [0] * 10
        self.totalRestocks = 0
        self.totalInterrupts = 0
        self.CONum = list(range(1, 11))

        print("Python version & info:: ", sys.version)
        print()
        print("Your 10-digit seed")
        print(randomSeed)
        print("Your 10-digit seed")
        print(randomSeed)
        print()

        print("Running class Warehouse __init__ fcn at time ",
              self.env.now,
              " for warehouse ",
              self.name,
              " // random pkg seed is ",
              randomSeed)

        # Start the interrupt handler
        self.restockHandlerProc = self.env.process(self.restockInterruptHandler())

        # Start periodic RRR reporter
        self.env.process(self.pendingRestocksReporter())

    # Register CO
    def registerCO(self, co_obj):
        self.co_dict[co_obj.label] = co_obj

    # CO recorded stockout
    def recordStockout(self, number):
        self.stockoutCounts[number - 1] += 1

    # Interrupt handler
    def restockInterruptHandler(self):
        while True:
            try:
                yield self.env.timeout(1000)
            except simpy.Interrupt as e:
                self.totalInterrupts += 1
                co_label = e.cause   # "CO3"
                num = int(co_label[2:])
                pretty = f"CO {num}"

                print(f"    III  {pretty}  is interrupting warehouse w at time  {self.env.now}")
                print(f"Start scheduling & delivering restock to {pretty}  at time  {self.env.now}")

                # Create shared event if needed
                if co_label not in self.se_dict:
                    self.se_dict[co_label] = self.env.event()

                self.env.process(self.doRestock(co_label))

    # Restock process
    def doRestock(self, co_label):
        delay = int(random.uniform(1, 4))
        yield self.env.timeout(delay)

        co = self.co_dict[co_label]
        self.totalRestocks += 1
        co.I = co.maxInv

        num = co.number
        pretty = f"CO {num}"

        if co.inStockout:
            print(f"  CRAS  {pretty}  completed re-stock AFTER stockout; resume w. I(t)=  {co.I}  at time  {self.env.now}")
        else:
            print(f"    CNS {pretty}  completed NON-STOCKOUT re-stocking, resuming w. I(t)=  {co.I}  at time  {self.env.now}")

        if co_label in self.se_dict:
            self.se_dict.pop(co_label).succeed()

        co.restockRequested = False

    # RRR reporter
    def pendingRestocksReporter(self):
        while True:
            yield self.env.timeout(10)
            pending = sorted([f"CO{int(lbl[2:])}" for lbl in self.se_dict.keys()],
                             key=lambda x: int(x[2:]))
            print(f"    RRR  Report - The COks with pending restocks at time  {self.env.now} ::  {pending}")
            if self.env.now >= SIM_END_TIME:
                break


# ==========================================================
# Contractor-Only Class
# ==========================================================
class CO:

    def __init__(self, env, number, initInv, warehouse, startDelay):
        self.env = env
        self.number = number
        self.label = f"CO{number}"
        self.I = initInv
        self.maxInv = initInv
        self.rp = RP

        self.warehouse = warehouse
        self.startDelay = startDelay

        self.restockRequested = False
        self.inStockout = False

        warehouse.registerCO(self)

        print(f"    Created CO instance  {self.label}  with init I(t) value  {self.I}")

        if self.startDelay == 0:
            print(f"Starting doOrders() for CO {self.number}  at time  {self.env.now}  with Init inventory  {self.I}  and RP  {self.rp}")

    def doOrders(self):
        global printed_deferred_header

        if self.startDelay > 0:
            yield self.env.timeout(self.startDelay)

            if not printed_deferred_header:
                print()
                print("COks that are beginning a deferred startup")
                print()
                print(" at t=15")
                printed_deferred_header = True

            print(f"Starting doOrders() for CO {self.number}  at time  {self.env.now}  with Init inventory  {self.I}  and RP  {self.rp}")

        while True:
            yield self.env.timeout(int(random.uniform(1, 3)))
            sale = int(random.uniform(40, 61))

            if self.I - sale < 0:
                pretty = f"CO {self.number}"
                print(f"    SSS - Stockout occured for {pretty}  at time  {self.env.now}")

                self.inStockout = True
                self.warehouse.recordStockout(self.number)

                se = self.warehouse.se_dict[self.label]
                yield se
                self.inStockout = False
                continue

            self.I -= sale
            pretty = f"CO {self.number}"
            print(f"{pretty}  I(t) level is  {self.I}  at time  {self.env.now}")

            if self.I < self.rp and not self.restockRequested:
                self.restockRequested = True
                self.warehouse.restockHandlerProc.interrupt(self.label)
                yield self.env.timeout(0)


# ==========================================================
# MAIN
# ==========================================================
def main():
    print("\n================= START SIMULATION =================\n")

    env = simpy.Environment()
    warehouse = Warehouse(env, "WH1")

    print("Creating  10  CO stores, some of which start orders after a delay")

    co_list = []
    for k in range(1, 11):
        initInv = 300 if k in (1, 10) else 200
        startDelay = 15 if k in (5, 6) else 0

        co = CO(env, k, initInv, warehouse, startDelay)
        co_list.append(co)
        env.process(co.doOrders())

    env.run(until=SIM_END_TIME)

    print(f"Finished run at model time  {SIM_END_TIME} \n")
    print(" Summary Report\n")

    totalSO = sum(warehouse.stockoutCounts)
    print("Grand total number of stockouts over all COk  ", totalSO)
    print()
    print("Required run Summary reporting")
    print("Total number of restocks completed & interrupts thrown by all COk  ",
          f"{warehouse.totalRestocks}  &  {warehouse.totalInterrupts}")
    print("Number of stockouts, by COk number  ",
          warehouse.stockoutCounts)
    print()

    lp.linePlot(
        plotRef=plt,
        varRange=warehouse.CONum,
        varValues=warehouse.stockoutCounts
    )
    plt.show()


if __name__ == "__main__":
    main()
