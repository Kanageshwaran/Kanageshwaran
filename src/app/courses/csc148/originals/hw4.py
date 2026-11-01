# =======================================================
# Name: Kanageshwaran Dhakshinamoorthy
# Course: CSC 148 – Programming with SimPy (Fall 2025)
# Instructor: Prof. Mitchell
# Assignment: Homework 4 – SimPy Inventory Model (MI Model)
# Date: November 11, 2025
#
# Description:
#   This program implements a Type-2 Inventory (MI) simulation using SimPy.
#   A Warehouse (W1) supplies initial inventory to five Contractor-Only 
#   sales sites (CO0–CO4). Each CO site continually processes random sales
#   of widgets until its inventory level drops below the restock threshold 
#   RP = 50. Sales occur at random intervals of 1–2 hours, and each sale size 
#   is a uniformly distributed integer between 30 and 49 widgets.
#
#   The simulation prints:
#       • Initialization of W1 and CO sites
#       • Start of each CO sales process at t = 0
#       • Inventory I(t) after each sale event
#       • Termination message for each CO once I(t) < RP
#       • Periodic warehouse reports listing all completed CO sites
#       • Final accounting summary after all CO sites have finished
#
#   A histogram of all sale sizes is generated using the instructor-provided
#   plotDisplay.py module located on the CSUS IRT server.
#
#   This file follows the exact structure and format required by the
#   assignment specification for HW4 and is fully compatible with the
#   IRT server execution environment.
#
# =======================================================
import simpy
import numpy as np
import random
import sys
import matplotlib.pyplot as plt

# Import plotDisplay from instructor's directory
sys.path.append('/home/college/mitchell/simpy3demos')
import plotDisplay as plotSrc

# Seed value
seedName = 123456
np.random.seed(seedName)


# =======================================================
# Warehouse Class
# =======================================================
class W:
    def __init__(self, env, name):
        self.env = env
        self.name = name
        self.finishedSites = {}

        print(f"Created Warehouse instance named  {self.name}  at time  {env.now}  seed is {seedName}")

    def numDoneReport(self):
        yield self.env.timeout(0)
        print("... Starting numDoneReport")

        interval = 1
        while True:
            yield self.env.timeout(interval)
            print(f"### Sites that are finished at time  {self.env.now} ::  {self.finishedSites}")

            if len(self.finishedSites) == 5:
                break

        print(f"\nAll COk have finished at t={self.env.now}.")
        print("... numDoneReport finished execution at time: ", self.env.now)


# =======================================================
# Contractor-Only Site (CO)
# =======================================================
class CO:
    def __init__(self, env, name, initInv, warehouse):
        self.env = env
        self.name = name
        self.I = initInv
        self.warehouse = warehouse

        print(f"    Created CO instance  {self.name}  with init I(t) value  {self.I}")

    def doSale(self):
        print(f"Starting doSale for CO  {self.name}  at time  {self.env.now}")

        RP = 50
        global salesSizeData

        while True:
            delay = int(np.random.uniform(1, 3))
            yield self.env.timeout(delay)

            saleSize = int(np.random.uniform(30, 50))
            salesSizeData.append(saleSize)

            self.I -= saleSize

            print(f"Site  {self.name}  has I(t) value  {self.I}  at time  {self.env.now}")

            if self.I < RP:
                print(f"  %%% CO  {self.name}  finished sales at time  {self.env.now}")
                self.warehouse.finishedSites[self.name] = "done"
                break


# =======================================================
# MAIN SIMULATION
# =======================================================
def main():

    print("\n================= START SIMULATION =================\n")

    global salesSizeData
    salesSizeData = []

    env = simpy.Environment()
    warehouse = W(env, "W1")

    initVals = [250, 250, 250, 250, 500]

    for i in range(5):
        coName = f"CO{i}"
        coObj = CO(env, coName, initVals[i], warehouse)
        env.process(coObj.doSale())

    env.process(warehouse.numDoneReport())
    env.run()

    print("\n===== Final Accounting =====")

    totalSales = sum(salesSizeData)
    print("Total sales amounts over all COk was ", totalSales)

    print("Number of elements in salesSizeData list is ", len(salesSizeData))

    bins = 20
    plotSrc.plotDisplay(
        salesSizeData,
        "Sale Sizes Histogram",
        "Possible Sale Sizes",
        "Frequency",
        bins
    )

    # Save histogram for personal viewing (not required for grading)
    plt.savefig("histogram.png")
    plt.close()

    print("\n================== END SIMULATION ==================\n")


if __name__ == "__main__":
    main()
