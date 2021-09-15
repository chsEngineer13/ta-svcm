package ru.gazpromproject.ta.svcm.stream.logic;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StreamDistributorsRunner implements Runnable {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(StreamDistributorsRunner.class);

    @Override
    public void run() {
        StreamDistributor[] distributors = {
                new StreamContractDistributor(),
                new StreamConstructionDistributor(),
                new StreamConstrPartDistributor(),
                new StreamBuildingDistributor(),
                new StreamDocsetDistributor()
        };
        
        for (StreamDistributor distributor : distributors) {
            distributor.distributeNew();
        }
    } 
}