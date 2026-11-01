import simpy
import random
import sys
import matplotlib.pyplot as plt

sys.path.append('/home/college/mitchell/simpy3demos')
import linePlot as lp

s = 1234567890
random.seed(s)
RP = 100
END = 49
dh = False

class W:
    def __init__(self, e, n):
        self.e = e
        self.n = n
        self.c = {}
        self.ev = {}
        self.so = [0]*10
        self.tr = 0
        self.ti = 0
        self.cn = list(range(1,11))

        print("Python version & info:: ", sys.version)
        print()
        print("Your 10-digit seed")
        print(s)
        print("Your 10-digit seed")
        print(s)
        print()
        print("Running class Warehouse __init__ fcn at time ",
              self.e.now, " for warehouse ", self.n,
              " // random pkg seed is ", s)

        self.h = self.e.process(self.ih())
        self.e.process(self.rr())

    def reg(self, o):
        self.c[o.l] = o

    def add(self, k):
        self.so[k-1] += 1

    def ih(self):
        while True:
            try:
                yield self.e.timeout(1000)
            except simpy.Interrupt as z:
                self.ti += 1
                L = z.cause
                k = int(L[2:])
                p = f"CO {k}"
                print(f"    III  {p}  is interrupting warehouse w at time  {self.e.now}")
                print(f"Start scheduling & delivering restock to {p}  at time  {self.e.now}")
                if L not in self.ev:
                    self.ev[L] = self.e.event()
                self.e.process(self.rs(L))

    def rs(self, L):
        d = int(random.uniform(1,4))
        yield self.e.timeout(d)
        o = self.c[L]
        self.tr += 1
        o.I = o.mx
        k = o.k
        p = f"CO {k}"
        if o.st:
            print(f"  CRAS  {p}  completed re-stock AFTER stockout; resume w. I(t)=  {o.I}  at time  {self.e.now}")
        else:
            print(f"    CNS {p}  completed NON-STOCKOUT re-stocking, resuming w. I(t)=  {o.I}  at time  {self.e.now}")
        if L in self.ev:
            self.ev.pop(L).succeed()
        o.rr = False

    def rr(self):
        while True:
            yield self.e.timeout(10)
            P = sorted([f"CO{int(x[2:])}" for x in self.ev.keys()],
                       key=lambda y: int(y[2:]))
            print(f"    RRR  Report - The COks with pending restocks at time  {self.e.now} ::  {P}")
            if self.e.now >= END:
                break


class C:
    def __init__(self, e, k, I, w, sd):
        self.e = e
        self.k = k
        self.l = f"CO{k}"
        self.I = I
        self.mx = I
        self.rp = RP
        self.w = w
        self.sd = sd
        self.rr = False
        self.st = False
        w.reg(self)

        print(f"    Created CO instance  {self.l}  with init I(t) value  {self.I}")
        if self.sd == 0:
            print(f"Starting doOrders() for CO {self.k}  at time  {self.e.now}  with Init inventory  {self.I}  and RP  {self.rp}")

    def run(self):
        global dh
        if self.sd > 0:
            yield self.e.timeout(self.sd)
            if not dh:
                print()
                print("COks that are beginning a deferred startup")
                print()
                print(" at t=15")
                dh = True
            print(f"Starting doOrders() for CO {self.k}  at time  {self.e.now}  with Init inventory  {self.I}  and RP  {self.rp}")

        while True:
            yield self.e.timeout(int(random.uniform(1,3)))
            v = int(random.uniform(40,61))

            if self.I - v < 0:
                p = f"CO {self.k}"
                print(f"    SSS - Stockout occured for {p}  at time  {self.e.now}")
                self.st = True
                self.w.add(self.k)
                ev = self.w.ev[self.l]
                yield ev
                self.st = False
                continue

            self.I -= v
            p = f"CO {self.k}"
            print(f"{p}  I(t) level is  {self.I}  at time  {self.e.now}")

            if self.I < self.rp and not self.rr:
                self.rr = True
                self.w.h.interrupt(self.l)
                yield self.e.timeout(0)


def main():
    print("\n================= START SIMULATION =================\n")

    e = simpy.Environment()
    w = W(e,"WH1")

    print("Creating  10  CO stores, some of which start orders after a delay")

    for k in range(1,11):
        I = 300 if k in (1,10) else 200
        sd = 15 if k in (5,6) else 0
        o = C(e,k,I,w,sd)
        e.process(o.run())

    e.run(until=END)

    print(f"Finished run at model time  {END} \n")
    print(" Summary Report\n")

    T = sum(w.so)
    print("Grand total number of stockouts over all COk  ", T)
    print()
    print("Required run Summary reporting")
    print("Total number of restocks completed & interrupts thrown by all COk  ",
          f"{w.tr}  &  {w.ti}")
    print("Number of stockouts, by COk number  ", w.so)
    print()

    lp.linePlot(
        plotRef=plt,
        varRange=w.cn,
        varValues=w.so
    )
    plt.show()


if __name__ == "__main__":
    main()
