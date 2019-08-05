import FWCore.ParameterSet.Config as cms
import FWCore.ParameterSet.VarParsing as VarParsing

def customize_general(process):

    # Other misc customizations
    process.Timing = cms.Service("Timing",
        summaryOnly = cms.untracked.bool(True)
        )
    process.MessageLogger.cerr.FwkReport.reportEvery = 100
    process.MessageLogger.cerr.threshold = ""
    # Avoid segfault (according to the official twiki)
    process.add_(cms.Service('InitRootHandlers',EnableIMT=cms.untracked.bool(False)))
    return process

def customize_dummy(process):
    return process
