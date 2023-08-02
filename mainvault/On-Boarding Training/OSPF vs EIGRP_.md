- OSPF: link-state
    
    - - map of entire topology (link-state database)
            \- uses a collective hive-mind-like to generate a topology
            \- administrative distance of 110
            \- administrative distance is calculated by cost
            \- cost = Reference bandwidth / Interface bandwidth
        - cost is the default metric for ospf
            \- default reference bandwidth = 100Mbps

<img src="../_resources/042F14A7-26DF-4B41-AD88-5D612C420DD5.jpeg" alt="042F14A7-26DF-4B41-AD88-5D612C420DD5.jpeg" width="489" height="276" class="jop-noMdConv">

- - - - - if interface BW is higher speed this can cause bad route; FIX: set the reference bandwidth to a higher speed
                - Hello interval
                - Dead interval: How long the route should wait for next hello interval before dropping the route <--- difference
                - load balances across equal cost links
- EIGRP: Distance-vector
    
    - one or more alternate routes (benefit over other distance-vector protocols)
    - has a lower (90) administrative distance, "more believable" in route destinations
    - metric calculation:
        - B:andwidth
        - D:elay
        - R:eliability
        - L:oad
        - M:TU
    - Hello Interval
    - hold interval: tells a neighbour how long to wait before considering dropping the route <----- different interval
    - can load balance across unequal cost links using a variance feature

<img src="../_resources/Screenshot%202023-02-27%20at%2013.47.37.png" alt="Screenshot 2023-02-27 at 13.47.37.png" width="635" height="337" class="jop-noMdConv">