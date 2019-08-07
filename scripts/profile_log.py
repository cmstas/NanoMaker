#!/usr/bin/env python3

import time
import pandas as pd
import numpy as np
import argparse

"""
Add
    process.Timing = cms.Service("Timing",
        summaryOnly = cms.untracked.bool(False)
        )
to a pset and redirect the cmsRun output to a text file.
Feed this script the text file to see which modules/producers
take the most time.
"""

if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument("logfile", help="logfile")
    args = parser.parse_args()

    ievent = 0
    data = []
    with open(args.logfile,"r") as fh:
        for line in fh:
            if line.startswith("TimeEvent>"): ievent += 1
            if not line.startswith("TimeModule>"): continue
            parts = line.split()
            data.append([ievent,parts[3],parts[4],parts[5]])
            
    dfc = pd.DataFrame(data,columns=["event","module","producer","dt"])
    dfc["module"] = dfc["module"].astype("category")
    dfc["producer"] = dfc["producer"].astype("category")
    dfc["dt"] = dfc["dt"].astype(float)
    # total event time
    dfc["etime"] = dfc.groupby("event")["dt"].transform("sum")
    # fraction of event time for given (module,producer)
    dfc["fracdt"] = dfc["dt"]/dfc["etime"]
    # throw away first and last 5 events
    dfc = dfc[(dfc.event > 5) & (dfc.event < dfc.event.max()-5)]

    print("Avg event rate",1./dfc.groupby("event")["dt"].sum().mean())

    print("\nFraction of event time taken by hungriest (module,producer) pairs")
    print("-"*50)
    print(dfc.groupby(["module","producer"])["fracdt"].mean().sort_values(ascending=False).head(30))
