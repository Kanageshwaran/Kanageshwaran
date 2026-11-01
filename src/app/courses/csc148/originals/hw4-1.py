# =======================================================
# CSC 148 – Homework 4
# Complete SimPy Inventory Model (Final Version)
# =======================================================

import simpy
import numpy as np
import random
import sys
import pdb

# Required for plotDisplay on IRT servers
sys.path.append('/home/college/mitchell/simpy3demos')
import plotDisplay as plotSrc

# ---------- GLOBAL SEED ----------
seedName = 123456  # <-- choose any 6+ digit seed you want
np.random.seed(seedName)


# =======================================================
# CLASS: Warehouse (W)
# =======================================================
class W:
    def __init__(self, env, name):
        self.env = env
        self.name = name
        self.finishedSites = {}  # dictionary of completed CO sites

        print(f"Created Warehouse instance named  {self.name}  at time  {env.now}  seed is {seedName}")

    # Inventory initialization placeholder (not used in h4)
    def initInventoryForCO(self, coObj, initialAmount):
        pass

    # ---------- Reporting Process ----------
    def numDoneReport(self):
        yield self.env.timeout(0)

        print("... Starting numDoneReport")
        reportInterval = 1  # check every 1 hour

        while True:
            yield self.env.timeout(reportInterval)

            print(f"### Sites that are finished at time  {self.env.now} ::  {self.finishedSites}")

            # Stop after all 5 CO sites have finished
            if len(self.finishedSites) == 5:
                break

        print(f"\nAll COk have finished at t={self.env.now}.")
        print("... numDoneReport finished execution at time: ", self.env.now)


# =======================================================
# CLASS: Contractor-Only Site (CO)
# =======================================================
class CO:
    def __init__(self, env, name, initialInventory, warehouse):
        self.env = env
        self.name = name
        self.I = initialInventory
        self.warehouse = warehouse

        print(f"    Created CO instance  {self.name}  with init I(t) value  {self.I}")

    # ---------- Sale Process ----------
    def doSale(self):
        print(f"Starting doSale for CO  {self.name}  at time  {self.env.now}")

        RP = 50  # restock (termination) threshold
        global salesSizeData

        while True:

            # Random delay between sales: 1 or 2 hours
            delay = int(np.random.uniform(1, 3))
            yield self.env.timeout(delay)

            # Random sale size: 30–49 widgets
            saleSize = int(np.random.uniform(30, 50))
            salesSizeData.append(saleSize)

            # Decrease inventory
            self.I -= saleSize

            # Required event print
            print(f"Site  {self.name}  has I(t) value  {self.I}  at time  {self.env.now}")

            # Stop once inventory drops below restock threshold RP
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
    salesSizeData = []  # All sale sizes collected for histogram

    env = simpy.Environment()

    # Create warehouse
    warehouse = W(env, "W1")

    # Create 5 CO sites with required initial inventory
    initVals = [250, 250, 250, 250, 500]
    CO_list = []

    for i in range(5):
        coName = f"CO{i}"
        coObj = CO(env, coName, initVals[i], warehouse)
        CO_list.append(coObj)
        env.process(coObj.doSale())

    # Start reporting process
    env.process(warehouse.numDoneReport())

    # Run simulation until warehouse reporting ends
    env.run()

    print("\n===== Final Accounting =====")

    # Total widgets sold
    totalSalesAmount = sum(salesSizeData)
    print("Total sales amounts over all COk was ", totalSalesAmount)

    # Number of sale events
    print("Number of elements in salesSizeData list is ", len(salesSizeData))

    # Histogram Plot
    bins = 20  # Enough to cover values 30–49
    plotSrc.plotDisplay(
        salesSizeData,
        "Sale Sizes Histogram",
        "Possible Sale Sizes",
        "Frequency",
        bins
    )

    print("\n================== END SIMULATION ==================\n")


# =======================================================
# Start Program
# =======================================================
if __name__ == "__main__":
    main()
