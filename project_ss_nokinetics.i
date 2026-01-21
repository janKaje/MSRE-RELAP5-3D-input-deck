* Title Of Deck
= proj
*******************************************************************************
*                                                                             *
*                                                                             *
*                  Project:  MSRE                                             *
*                  Jacob Purser                                               *
*                  Spencer Jensen                                             *
*                  Kyle Duke                                                  *
*                                                                             *
*                                                                             *
*                  Version 9 (final?)                                         *
*                                                                             *
*******************************************************************************
*
*******************************************************************************
*                                                                             *
*                       Miscellaneous Control Cards                           *
*                                                                             *
*******************************************************************************
*
*      Type     Option
100    new      transnt
*      Inp-Chk/Run
101    run
*      Input-Units     Output-Units
102    si              si
*      CPUrem1   CPUrem2   CPUalloted
105    5.0       6.0       5000.0
*      Noncondesible
110    nitrogen
*      Ref-Vol       Elev    Fluid   Name
120    300010000     0.0     ms1     'Primary'
121    200010000     0.0     ms1     'Coolant'
* TEMPORARY - until we hook up new core
* 122    300010000     0.0     ms1     'Core'
*
*******************************************************************************
*                                                                             *
*                           Time Step Control Cards                           *
*                                                                             *
*******************************************************************************
*
*      TimeEnd  MinStep  MaxStep  Ssdtt  MinorEditFreq  MajEditFreq  ResrtFreq
201    2000.    1.0e-9  0.1      00000  10             300          300    
*
*
*******************************************************************************
*                                                                             *
*                          Expanded Plot Variables                            *
*                                                                             *
*******************************************************************************
*
*           Variable-Code      Parameter
20800001    timeof             401
*
*
*******************************************************************************
*                                                                             *
*                                    Trips                                    *
*                                                                             *
*******************************************************************************
*      VarCode  Parameter  Rel  VarCode  Parameter  AddConst  Latch  * trip for trip valve 105, loss of flow 
401    time     0          ge   null     0          5000000.      n
402    time     0          lt   null     0          0.0       n    
*
*
*
*
*******************************************************************************
*                                                                             *
*                         Control System Input Data                           *
*  
*
* core heat deposited in primary Fluid
* primary heat exchanger Q
*     Q = mdot*(H2-H1) H of the heat exchangers in and out
*      use a sum, and -1 for the a of the 
* secondary Heat exchanger Q 
*      delta(mdot)*delta(T) of the time dependent junctions 
* liquid levels???? 
* cumulative flows????                           
* Request codes needed:
*    flenth - total enthalpy flow through junction (J/s)
*******************************************************************************
*
*core heat depositied in primary fluid = enthaalpy in junction out of core - ehthalpy into core
*           Format
20500000    999
*
*    Control card 010: core heat deposited in primary fluid
*           Name       Type  ScalingFactor  InitialValue  Flag   Limiter
20501000    Qdotcore   sum   1.0            0.0           1      0
*           A0     A1       variableCode   Parameter                                                            *** Depends On Type Used Above (Appendix A14-2)
20501001    0.0    1.0      flenth         305010000
*           A2              variableCode   Parameter
20501002    -1.0            flenth         109000000
*
*    Control card 020: heat duty of primary heat exchanger
*           Name       Type  ScalingFactor  InitialValue  Flag   Limiter
20502000    qdothx1    sum   1.0            0.0           1      0
*           A0     A1       variableCode   Parameter                                                            *** Depends On Type Used Above (Appendix A14-2)
20502001    0.0    1.0      flenth         105000000
*           A2              variableCode   Parameter
20502002    -1.0            flenth         103020000
*
*    Control card 030: heat duty of secondary heat exchanger
*           Name       Type  ScalingFactor  InitialValue  Flag   Limiter
20503000    qdothx2    sum   1.0            0.0           1      0
*           A0     A1       variableCode   Parameter                                                            *** Depends On Type Used Above (Appendix A14-2)
20503001    0.0    1.0      flenth         205000000
*           A2              variableCode   Parameter
20503002    -1.0            flenth         203000000
*
*
*    Control card 040: center core heat deposited in primary fluid
*           Name       Type  ScalingFactor  InitialValue  Flag   Limiter
20504000    QcntCore   sum   1.0            0.0           1      0
*           A0     A1       variableCode   Parameter                                                            *** Depends On Type Used Above (Appendix A14-2)
20504001    0.0    1.0      flenth         301040000
*           A2              variableCode   Parameter
20504002    -1.0            flenth         305040000
*
*
*    Control card 050: inner core heat deposited in primary fluid
*           Name       Type  ScalingFactor  InitialValue  Flag   Limiter
20505000    QinrCore   sum   1.0            0.0           1      0
*           A0     A1       variableCode   Parameter                                                            *** Depends On Type Used Above (Appendix A14-2)
20505001    0.0    1.0      flenth         301030000
*           A2              variableCode   Parameter
20505002    -1.0            flenth         305030000
*
*
*
*    Control card 060: outer core heat deposited in primary fluid
*           Name       Type  ScalingFactor  InitialValue  Flag   Limiter
20506000    QcntCore   sum   1.0            0.0           1      0
*           A0     A1       variableCode   Parameter                                                            *** Depends On Type Used Above (Appendix A14-2)
20506001    0.0    1.0      flenth         301020000
*           A2              variableCode   Parameter
20506002    -1.0            flenth         305020000
*
*    Control card 100: average core fuel temperature
*           Name       Type  ScalingFactor  InitialValue  Flag   Limiter
20510000    coretemp   sum   0.0333333      0             1      0
*           A0     A1       variableCode   Parameter
20510001    0.0    1.0      tempf          302010000
+ 1.0 tempf 302020000  1.0 tempf 302030000  1.0 tempf 302040000  
+ 1.0 tempf 302050000  1.0 tempf 302060000  1.0 tempf 302070000  
+ 1.0 tempf 302080000  1.0 tempf 302090000  1.0 tempf 302100000  
+ 1.0 tempf 303010000  1.0 tempf 303020000  1.0 tempf 303030000  
+ 1.0 tempf 303040000  1.0 tempf 303050000  1.0 tempf 303060000  
+ 1.0 tempf 303070000  1.0 tempf 303080000  1.0 tempf 303090000  
+ 1.0 tempf 303100000  1.0 tempf 304010000  1.0 tempf 304020000  
+ 1.0 tempf 304030000  1.0 tempf 304040000  1.0 tempf 304050000  
+ 1.0 tempf 304060000  1.0 tempf 304070000  1.0 tempf 304080000  
+ 1.0 tempf 304090000  1.0 tempf 304100000
*
*******************************************************************************
*                                                                             *
*                           Hydrodynamic Components                           *
*                                                                             *
*******************************************************************************
*
* *********************************
* *   Core - 100 - Single Volume  *
* *********************************
* *          Name    Type
* 1000000    core    snglvol
* *          Area       Length   Volume
* 1000101    1.82415    2.4384   0.0
* *          AzimAng   InclAng    ElevationChange
* 1000102    0.0       90.0       2.4384
* *          Roughness  HydraulicDiam  Tlpvbfe
* 1000103    0.0        0.0            0000000
* *          Ebt       Initial-Conditions
* 1000200    003       137900.     908.0
*
***************************************
* Out of core - Single Junction - 101 *
***************************************
*          Name    Type
* 1010000    jun1    sngljun
*          From         To          Area
* 1010101    305010000    102000000   0.0126677
*          Af     Ar     Jefvcahs 
* 1010102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
* 1010201    1        1.0        0.0    0.0
*
****************************
* Out of core - Pipe - 102 *
****************************
*          Name     Type
1020000    pipe1    pipe
*          NumOfVolumes
1020001    10
*          Area                      VolNum
1020101    0.0126677                 10
*          Length                    VolNum
1020301    1.0                       10
*          Volume                    VolNum
1020401    0.0                       10
*          AzimAng                   VolNum
1020501    0.0                       10
*          InclAng                   VolNum
1020601    90.0                      10
*          Roughness  HydraulicDiam  VolNum
1020801    2.0e-6     0.0            10
*          Af         Ar             JunNum
1020901    0.0        0.0            9  
*          tlpvbfe                   VolNum
1021001    0000000                   10
*          Jefvcahs                  JunNum
1021101    00000000                  9
*          Ebt   Initial-Conditions     VolNum
1021201    003   137900.     908.0  0.  0.  0.  10
*          Vel/Mfr
1021300    1
*          Liquid  Vapor  Interface  JunNum
1021301    1.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
1021401    0.0        0.0       1.0   1.0    9
*
******************************************
* To pressurizer - Single Junction - 151 *
******************************************
*          Name    Type
1510000    pzrj    sngljun
*          From         To          Area
1510101    102100003    150000000   0.0126677
*          Af     Ar     Jefvcahs 
1510102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
1510201    1        0.0        0.0    0.0
*
***********************
*  Pressurizer - 150  *
***********************
*          Name    Type
1500000    pzr     tmdpvol
*          Area    Length   Volume
1500101    10.0    10.0     0.0
*          AzimAng   InclAng   ElevationChange
1500102    0.0       0.0       0.0
*          Roughness  HydraulicDiam  Tlpvbfe
1500103    0.0        0.0            0000000
*          Ebt       TripNum   SearchVar
1500200    003       0         time
*          SearchVar      Initial-Conditions
1500201    0.0            149575.0     935.93
*
**************************************************
* Fuel salt pump - Time Dependent Junction - 103 *
**************************************************
*          Name       Type
1030000    fuelpump   pump
*          Area        Length  Volume   AzimAng  InclAng  ElevationChange  tlpvbfe 
1030101    0.1         0.0     0.1161   0.0      0.0      0.0              0
*          From        Area    Af      Ar      jefvcahs
1030108    102010000   0.0     0.0   0.0   0000
*          To          Area    Af      Ar      jefvcahs         
1030109    104000000   0.0     0.0     0.0     0000
*          Ebt   Initial-Conditions
1030200    3     137900.   908.0   0.0
*Inlet     Vel/Mfr   Liquid  Vapor  Interface 
1030201    1         1.0   0.0    0.0
*Outlet    Vel/Mfr   Liquid  Vapor  Interface
1030202    1         1.0   0.0   0.0
*          PumpInd 2PhaseIndex  2PhaseTable TrqTable VelIndex TripNum ReverseIn
1030301    0       -1           -3          -1       0        0      0
*          Vel    Ratio    Flow        Head     Torque      MOI      Density
1030302    1150.  1.0      0.07570824  14.7828  3.69670     820.     1946.32
* NOTE: MOI is not in the project report. We wll need to vary this until the spindown takes
* roughly 10 seconds (which is in project report).
*          MotorTrq  FrictionTrq2  FrictionTrq0  FrictionTrq1  FrictionTrq3
1030303    3.69670   0.            80.           0.0           0.0
*          TripNum
1036100    0
*          SearchVar    Velocity
1036101   -1.           1150.0
1036102    0.           1150.0
1036103    10.          1150.0
1036104    5.e5         1150.0
*          
*         Head curves
1031100   1   1
1031101   0.000000,  1.311909
1031102   0.036615,  1.387701
1031103   0.075811,  1.465488
1031104   0.121454,  1.529314
1031105   0.164721,  1.603111
1031106   0.208012,  1.672920
1031107   0.245725,  1.748713
1031108   0.287481,  1.800571
1031109   0.328041,  1.852429
1031110   0.370237,  1.908276
1031111   0.410441,  1.954151
1031112   0.454282,  1.990052
1031113   0.494509,  2.023959
1031114   0.535159,  2.053878
1031115   0.575417,  2.085790
1031116   0.617709,  2.085790
1031117   0.662436,  2.109725
1031118   0.702738,  2.113714
1031119   0.742649,  2.131665
1031120   0.791453,  2.133659
1031121   0.830193,  2.145626
1031122   0.874579,  2.147621
1031123   0.910908,  2.155599
1031124   0.957331,  2.155599
1031125   0.996907,  2.159588
1031126   1.000000,  2.159588
1031200   1   2
1031201   0.000000,  0.006034
1031202   0.666667,  0.006034
1031203   0.700730,  0.118419
1031204   0.738462,  0.248634
1031205   0.780488,  0.400755
1031206   0.827586,  0.580109
1031207   0.862836,  0.740598
1031208   0.892743,  0.858001
1031209   0.927549,  0.996565
1031210   0.961419,  1.142575
1031211   1.000000,  1.142575
1032100   2   1
1032101   0.000000,  0.000000
1032102   0.036615,  0.641641
1032103   0.075811,  0.686891
1032104   0.121454,  0.741920
1032105   0.164721,  0.785672
1032106   0.208012,  0.827866
1032107   0.245725,  0.869576
1032108   0.287481,  0.919542
1032109   0.328041,  0.959436
1032110   0.370237,  1.001888
1032111   0.410441,  1.043078
1032112   0.454282,  1.085648
1032113   0.494509,  1.120427
1032114   0.535159,  1.159263
1032115   0.575417,  1.195655
1032116   0.617709,  1.231240
1032117   0.662436,  1.264186
1032118   0.702738,  1.290691
1032119   0.742649,  1.319826
1032120   0.791453,  1.345597
1032121   0.830193,  1.357567
1032122   0.874579,  1.372779
1032123   0.910908,  1.383871
1032124   0.957331,  1.400013
1032125   0.996907,  1.401481
1032126   1.000000,  1.401481
1032200   2   2
1032201   0.000000,  0.046790
1032202   0.666667,  0.046790
1032203   0.700730,  0.483125
1032204   0.738462,  0.687718
1032205   0.780488,  0.837933
1032206   0.827586,  0.974382
1032207   0.862836,  1.055130
1032208   0.892743,  1.127800
1032209   0.927549,  1.214260
1032210   0.961419,  1.310874
1032211   1.000000,  1.310874
*
*******************
* HX - Pipe - 104 *
*******************
*          Name     Type
1040000    hxshell       pipe
*          NumOfVolumes
1040001    10
*          Area                      VolNum
1040101    0.109575                  10
*          Length                    VolNum
1040301    0.24384                   10
*          Volume                    VolNum
1040401    0.0                       10
*          AzimAng                   VolNum
1040501    0.0                       10
*          InclAng                   VolNum
1040601    0.0                       10
*          Roughness  HydraulicDiam  VolNum
1040801    2.0e-6     0.0313871      10
*          Af         Ar             JunNum
1040901    0.0        0.0            9  
*          tlpvbfe                   VolNum
1041001    0000000                   10
*          Jefvcahs                  JunNum
1041101    00000000                  9
*          Ebt   Initial-Conditions     VolNum
1041201    003   137900.     908.0  0.  0.  0.  10
*          Vel/Mfr
1041300    1
*          Liquid     Vapor  Interface  JunNum
1041301    1.0   0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
1041401    0.0        0.0       1.0   1.0    9
*
*************************************
* Out of HX - Single Junction - 105 *
*************************************
*          Name    Type
*1050000    jun2    sngljun
*          From         To          Area
*1050101    104010000    106000000   0.0126677
*          Af     Ar     Jefvcahs 
*1050102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
*1050201    1        1.0        0.0    0.0
*
*********************************
*          Valve - 105          *
*          From HX              *
*********************************
*          Name      Type
1050000    valve1    valve
*          From       To         Area        Kt   Kr   Efvcahs
1050101    104010000  106000000  0.0126677   0.0  0.0  0000100
*          SubCoolDisCoef   2PhaseDisCoef   SupHeatDisCoef
1050102    1.0              1.0             1.0
*          Vel/Mfr  Liquid  Vapor  Interface  
1050201    1        1.0     0.0    0.0
*          ValveType
1050300    mtrvlv
*          OpenTrp   CloseTrp   ChangeRate   InitPos 
1050301    402       401        0.1          1.0
*
*******************************
* Out of HX down - Pipe - 106 *
*******************************
*          Name     Type
1060000    pipe2    pipe
*          NumOfVolumes
1060001    10
*          Area                      VolNum
1060101    0.0126677                 10
*          JunArea                   JunNum 
1060201    0.0126677                 9
*          Length                    VolNum
1060301    1.0                       10
*          Volume                    VolNum
1060401    0.0                       10
*          AzimAng                   VolNum
1060501    0.0                       10
*          InclAng                   VolNum
1060601    -90.0                     10
*          Roughness  HydraulicDiam  VolNum
1060801    2.0e-6     0.0            10
*          Af         Ar             JunNum
1060901    0.0        0.0            9  
*          tlpvbfe                   VolNum
1061001    0000000                   10
*          Jefvcahs                  JunNum
1061101    00000000                  9
*          Ebt   Initial-Conditions     VolNum
1061201    003   137900.     908.0  0.  0.  0.  10
*          Vel/Mfr
1061300    1
*          Liquid  Vapor  Interface  JunNum
1061301    1.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
1061401    0.0        0.0       1.0   1.0    9
*
*************************************
* pipe bend - Single Junction - 107 *
*************************************
*          Name    Type
1070000    pipebend    sngljun
*          From         To          Area
1070101    106010000    108000000   0.0126677
*          Af     Ar     Jefvcahs 
1070102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
1070201    1        1.0        0.0    0.0
*
**************************
* Into core - Pipe - 108 *
**************************
*          Name        Type
1080000    intocore    pipe
*          NumOfVolumes
1080001    10
*          Area                      VolNum
1080101    0.0126677                 10
*          JunArea                   JunNum 
1080201    0.0126677                 9
*          Length                    VolNum
1080301    1.0                       10
*          Volume                    VolNum
1080401    0.0                       10
*          AzimAng                   VolNum
1080501    0.0                       10
*          InclAng                   VolNum
1080601    0.0                       10
*          Roughness  HydraulicDiam  VolNum
1080801    2.0e-6     0.0            10
*          Af         Ar             JunNum
1080901    0.0        0.0            9  
*          tlpvbfe                   VolNum
1081001    0000000                   10
*          Jefvcahs                  JunNum
1081101    00000000                  9
*          Ebt   Initial-Conditions     VolNum
1081201    003   137900.     908.0  0.  0.  0.  10
*          Vel/Mfr
1081300    1
*          Liquid  Vapor  Interface  JunNum
1081301    1.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
1081401    0.0        0.0       1.0   1.0    9
*
*************************************
* into core - Single Junction - 109 *
*************************************
*          Name    Type
1090000    intcore    sngljun
*          From         To          Area
1090101    108010000    300000000   0.0126677
*          Af     Ar     Jefvcahs 
1090102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
1090201    1        1.0        0.0    0.0
*
*
*********************************************
*                                           *
*              Secondary Loop               *
*                                           *
*********************************************
*
*
*********************************
* Other side of HX - Pipe - 200 *
*********************************
*          Name        Type
2000000    hxtubes          pipe
*          NumOfVolumes
2000001    20
*          Area                      VolNum
2000101    0.0139425                 20
*          Length                    VolNum
2000301    0.24384                   20
*          Volume                    VolNum
2000401    0.0                       20
*          AzimAng                   VolNum
2000501    0.0                       20
*          InclAng                   VolNum
2000601    0.0                       20
*          Roughness  HydraulicDiam  VolNum
2000801    0.0        0.0            20
*          Af         Ar             JunNum
2000901    0.0        0.0            19  
*          tlpvbfe                   VolNum
2001001    0000000                   20
*          Jefvcahs                  JunNum
2001101    00000000                  19
*          Ebt   Initial-Conditions     VolNum
2001201    003   137900.     866.5  0.  0.  0.  20
*          Vel/Mfr
2001300    1
*          Liquid   Vapor  Interface  JunNum
2001301    1.0  0.0    0.0        19
*          JunHydDia  Flooding  c     Slope  JunNum
2001401    0.0        0.0       1.0   1.0    19
*
*********************************
*     Single Junction - 201     *
*********************************
*          Name    Type
2010000    jun1    sngljun
*          From         To          Area
2010101    200010000    202000000   0.0
*          Af     Ar     Jefvcahs 
2010102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
2010201    1        1.0        0.0    0.0
*
*******************************
* towards air hx - Pipe - 202 *
*******************************
*          Name        Type
2020000    intocore    pipe
*          NumOfVolumes
2020001    10
*          Area                      VolNum
2020101    0.0129082                 10
*          Length                    VolNum
2020301    1.0                       10
*          Volume                    VolNum
2020401    0.0                       10
*          AzimAng                   VolNum
2020501    0.0                       10
*          InclAng                   VolNum
2020601    0.0                       10
*          Roughness  HydraulicDiam  VolNum
2020801    0.0        0.0            10
*          Af         Ar             JunNum
2020901    0.0        0.0            9  
*          tlpvbfe                   VolNum
2021001    0000000                   10
*          Jefvcahs                  JunNum
2021101    00000000                  9
*          Ebt   Initial-Conditions     VolNum
2021201    003   137900.     866.5  0.  0.  0.  10
*          Vel/Mfr
2021300    1
*          Liquid  Vapor  Interface  JunNum
2021301    1.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
2021401    0.0        0.0       1.0   1.0    9
*
*********************************
*     Single Junction - 203     *
*********************************
*          Name    Type
2030000    jun1    sngljun
*          From         To          Area
2030101    202010000    204000000   0.0
*          Af     Ar     Jefvcahs 
2030102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
2030201    1        1.0        0.0    0.0
*
***********************
* air hx - Pipe - 204 *
***********************
*          Name        Type
2040000    airhx       pipe
*          NumOfVolumes
2040001    10
*          Area                      VolNum
2040101    0.0242101                 10
*          JunArea                   JunNum 
2040201    0.0242101                 9
*          Length                    VolNum
2040301    0.9144                    10
*          Volume                    VolNum
2040401    0.0                       10
*          AzimAng                   VolNum
2040501    0.0                       10
*          InclAng                   VolNum
2040601    0.0                       10
*          Roughness  HydraulicDiam  VolNum
2040801    0.0        0.0160274      10
*          Af         Ar             JunNum
2040901    0.0        0.0            9  
*          tlpvbfe                   VolNum
2041001    0000000                   10
*          Jefvcahs                  JunNum
2041101    00000000                  9
*          Ebt   Initial-Conditions     VolNum
2041201    003   137900.     824.82  0.  0.  0.  10
*          Vel/Mfr
2041300    1
*          Liquid  Vapor  Interface  JunNum
2041301    1.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
2041401    0.0        0.0       1.0   1.0    9
*
*********************************
*     Single Junction - 205     *
*********************************
*          Name    Type
2050000    jun1    sngljun
*          From         To          Area
2050101    204010000    206000000   0.0
*          Af     Ar     Jefvcahs 
2050102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
2050201    1        1.0        0.0    0.0
*
*****************************
* towards pump - Pipe - 206 *
*****************************
*          Name        Type
2060000    intocore    pipe
*          NumOfVolumes
2060001    10
*          Area                      VolNum
2060101    0.0129082                 10
*          Length                    VolNum
2060301    1.0                       10
*          Volume                    VolNum
2060401    0.0                       10
*          AzimAng                   VolNum
2060501    0.0                       10
*          InclAng                   VolNum
2060601    0.0                       10
*          Roughness  HydraulicDiam  VolNum
2060801    0.0        0.0            10
*          Af         Ar             JunNum
2060901    0.0        0.0            9  
*          tlpvbfe                   VolNum
2061001    0000000                   10
*          Jefvcahs                  JunNum
2061101    00000000                  9
*          Ebt   Initial-Conditions     VolNum
2061201    003   137900.     824.82  0.  0.  0.  10
*          Vel/Mfr
2061300    1
*          Liquid  Vapor  Interface  JunNum
2061301    1.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
2061401    0.0        0.0       1.0   1.0    9
*
***************************
* Coolant salt pump - 207 *
***************************
*          Name       Type
2070000    clpump     pump
*          Area        Length  Volume   AzimAng  InclAng  ElevationChange  tlpvbfe 
2070101    0.0322763   0.0     4.1      0.0      0.0      0.0              0
*          From        Area    Af      Ar      jefvcahs
2070108    206010000   0.0129082   0.0   0.0   0000
*          To          Area    Af      Ar      jefvcahs         
2070109    208000000   0.0322763  0.0     0.0     0000
*          Ebt   Initial-Conditions
2070200    3     137900.   824.82   0.0
*Inlet     Vel/Mfr   Liquid  Vapor  Interface 
2070201    1         1.0   0.0    0.0
*Outlet    Vel/Mfr   Liquid  Vapor  Interface
2070202    1         1.0   0.0   0.0
*          PumpInd 2PhaseIndex  2PhaseTable TrqTable VelIndex TripNum ReverseIn
2070301    0       -1           -3          -1       0        0      0
*          Vel    Ratio    Flow        Head     Torque      MOI      Density
2070302    1750.  1.0      0.05362667  23.7744  2.76735     820.     1946.32
* NOTE: MOI is not in the project report. We will need to vary this until the spindown takes
* roughly 10 seconds (which is in project report).
*          MotorTrq  FrictionTrq2  FrictionTrq0  FrictionTrq1  FrictionTrq3
2070303    0.        0.            80.          0.0           0.0
*          TripNum
2076100    0
*          SearchVar    Velocity
2076101   -1.           1750.0
2076102    0.           1750.0
2076103    10.          1750.0
2076104    5.e5         1750.0
*          
*         Head curves
2071100   1   1
2071101   0.000000,  1.119586
2071102   0.051691,  1.151831
2071103   0.107028,  1.186556
2071104   0.171465,  1.215081
2071105   0.232547,  1.237404
2071106   0.293664,  1.258488
2071107   0.346906,  1.277091
2071108   0.405856,  1.296934
2071109   0.463117,  1.296934
2071110   0.522687,  1.311816
2071111   0.579446,  1.314296
2071112   0.641340,  1.325458
2071113   0.698130,  1.326698
2071114   0.755519,  1.334139
2071115   0.812353,  1.335380
2071116   0.872060,  1.340340
2071117   0.935204,  1.340340
2071118   0.992101,  1.342821
2071119   1.000000,  1.342821
*
2071200   1   2
2071201   0.000000,  0.231049
2071202   0.611176,  0.231049
2071203   0.632359,  0.267677
2071204   0.657014,  0.310905
2071205   0.681005,  0.356457
2071206   0.710531,  0.411829
2071207   0.739904,  0.472383
2071208   0.777612,  0.551005
2071209   0.809914,  0.623765
2071210   0.853215,  0.725651
2071211   0.894978,  0.833196
2071212   0.953793,  0.989177
2071213   1.000000,  0.989177
*
*         Torque curves
2072100   2   1
2072101   0.000000,  0.000000
2072102   0.051691,  0.563250
2072103   0.107028,  0.602972
2072104   0.171465,  0.651278
2072105   0.232547,  0.689685
2072106   0.293664,  0.726724
2072107   0.346906,  0.763339
2072108   0.405856,  0.807199
2072109   0.463117,  0.842220
2072110   0.522687,  0.879485
2072111   0.579446,  0.915643
2072112   0.641340,  0.953013
2072113   0.698130,  0.983542
2072114   0.755519,  1.017634
2072115   0.812353,  1.049580
2072116   0.872060,  1.080817
2072117   0.935204,  1.109738
2072118   0.992101,  1.133004
2072119   1.000000,  1.133004
*
2072200   2   2
2072201   0.000000,  0.464719
2072202   0.611176,  0.464719
2072203   0.632359,  0.496726
2072204   0.657014,  0.534806
2072205   0.681005,  0.577359
2072206   0.710531,  0.621101
2072207   0.739904,  0.672811
2072208   0.777612,  0.734567
2072209   0.809914,  0.790474
2072210   0.853215,  0.867537
2072211   0.894978,  0.946127
2072212   0.953793,  1.053985
2072213   1.000000,  1.053985
*
********************************
* towards salt hx - Pipe - 208 *
********************************
*          Name        Type
2080000    intocore    pipe
*          NumOfVolumes
2080001    10
*          Area                      VolNum
2080101    0.0129082                 10
*          Length                    VolNum
2080301    1.0                       10
*          Volume                    VolNum
2080401    0.0                       10
*          AzimAng                   VolNum
2080501    0.0                       10
*          InclAng                   VolNum
2080601    0.0                       10
*          Roughness  HydraulicDiam  VolNum
2080801    0.0        0.0            10
*          Af         Ar             JunNum
2080901    0.0        0.0            9  
*          tlpvbfe                   VolNum
2081001    0000000                   10
*          Jefvcahs                  JunNum
2081101    00000000                  9
*          Ebt   Initial-Conditions     VolNum
2081201    003   137900.     824.82  0.  0.  0.  10
*          Vel/Mfr
2081300    1
*          Liquid  Vapor  Interface  JunNum
2081301    1.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
2081401    0.0        0.0       1.0   1.0    9
*
*********************************
*     Single Junction - 209     *
*********************************
*          Name    Type
2090000    jun1    sngljun
*          From         To          Area
2090101    208010000    200000000   0.0
*          Af     Ar     Jefvcahs 
2090102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
2090201    1        1.0        0.0    0.0
*
*
*
******************************************
* To pressurizer - Single Junction - 251 *
******************************************
*          Name     Type
2510000    pzrj2    sngljun
*          From         To          Area
2510101    206100003    250000000   0.0126677
*          Af     Ar     Jefvcahs 
2510102    0.0    0.0    00000000
*          Vel/Mfr  Liquid     Vapor  Interface
2510201    1        0.0        0.0    0.0
*
***********************
*  Pressurizer - 250  *
***********************
*          Name     Type
2500000    pzr2     tmdpvol
*          Area    Length   Volume
2500101    10.0    10.0     0.0
*          AzimAng   InclAng   ElevationChange
2500102    0.0       0.0       0.0
*          Roughness  HydraulicDiam  Tlpvbfe
2500103    0.0        0.0            0000000
*          Ebt       TripNum   SearchVar
2500200    003       0         time
*          SearchVar      Initial-Conditions
2500201    0.0            259860.0     824.8
*
*
*
***************************************************************
*                   core hydrodynamic componenets
*
**************************************************************
*
*********************************
*   cooling jacket
*           Pipe - 300          *
*********************************
*          Name     Type
3000000    cooljkt    pipe
*          NumOfVolumes
3000001    10
*          Area                      VolNum
3000101    0.0598548                 10
*          JunArea                   JunNum 
3000201    0.0598548                 9
*          Length                    VolNum
3000301    0.170180                  10
*          Volume                    VolNum
3000401    0.0                       10
*          AzimAng                   VolNum
3000501    0.0                       10
*          InclAng                   VolNum
3000601    -90.0                     10
*          Roughness  HydraulicDiam  VolNum
3000801    0.0        0.276060727    10
*          Af         Ar             JunNum
3000901    0.0        0.0            9  
*          tlpvbfe                   VolNum
3001001    0000000                   10
*          Jefvcahs                  JunNum
3001101    00000000                  9
*          Ebt   Initial-Conditions             VolNum
3001201    003   137900.     908.0  0.  0.  0.  10
*          Vel/Mfr
3001300    1
*          Liquid  Vapor  Interface  JunNum
3001301    1.0    0.0    0.0         9
*          JunHydDia  Flooding  c     Slope  JunNum
3001401    0.0        0.0       1.0   1.0    9
*
*
*
*
*********************************
*   Branch/Sepatator - 301      *
* bottom of core goes into graphite channels
* called "bottom head" in documentation
*   page A7-59 in appendix A 
*    
*   
*********************************
*          Name       Type 
3010000   bothead    branch
*          NumOfJunctions     Vel/Mfr
3010001    4                  1
*          Area        Length   Volume
3010101    1.11387     0.254      0.0
*          AzimAng     InclAng   ElevationChange
3010102    0.0         0.0       0.0
*          Roughness   HydraulicDiam  Tlpvbfe
3010103    0.0         0.0            0000000
*          Ebt       Initial-Conditions
3010200    003       137900.     908.0  
*          From       To         Area  Kt   Kr   Efvcahs   * old format did not work, trying new format   F=1=inlet,F=2=outlet
3011101   300010000  301000000   0.0   0.0  0.0  0000000   
3012101   301010000  302000000   0.0   0.0  0.0  0000000   * junction to inner core/hottes point
3013101   301010000  303000000   0.0   0.0  0.0  0000000   * junction to mid temp region of core
3014101   301010000  304000000   0.0   0.0  0.0  0000000 
*          Liquid    Vapor    Interface=enter0.0  (initial velocities) 301N201 page A7-59
3011201    1.0       0.0      0.0
3012201    1.0       0.0      0.0
3013201    1.0       0.0      0.0
3014201    1.0       0.0      0.0
*
*********************************
*        center of core - hottest channel 
*       channels fuel flows through 
*         1/3 of chanels
*      need to change to graphite?
*           Pipe - 302          *
*********************************
*          Name     Type
3020000    core1    pipe
*          NumOfVolumes
3020001    10
*          Area                      VolNum
3020101    0.036420                  10
*          JunArea                   JunNum 
3020201    0.0                       9
*          Length                    VolNum
3020301    0.17018                   10
*          Volume                    VolNum
3020401    0.0                       10
*          AzimAng                   VolNum
3020501    0.0                       10
*          InclAng                   VolNum
3020601    90.0                      10
*          Roughness  HydraulicDiam  VolNum
3020801    0.0        0.0158506      10
*          Af         Ar             JunNum
3020901    0.0        0.0            9  
*          tlpvbfe                   VolNum
3021001    0000000                   10
*          Jefvcahs                  JunNum
3021101    00000000                  9
*          Ebt   Initial-Conditions             VolNum
3021201    003   137900.     908.0  0.  0.  0.  10
*          Vel/Mfr
3021300    1
*          Liquid  Vapor  Interface  JunNum
3021301    0.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
3021401    0.0        0.0       1.0   1.0    9
*
*********************************
*        inner core - between center and outer core sections 
*       channels fuel flows through 
*         1/3 of chanels
*      * need to change to graphite?
*           Pipe - 303          *
*********************************
*          Name     Type
3030000    core2    pipe
*          NumOfVolumes
3030001    10
*          Area                      VolNum
3030101    0.109259                  10
*          JunArea                   JunNum 
3030201    0.0                       9
*          Length                    VolNum
3030301    0.17018                   10
*          Volume                    VolNum
3030401    0.0                       10
*          AzimAng                   VolNum
3030501    0.0                       10
*          InclAng                   VolNum
3030601    90.0                      10
*          Roughness  HydraulicDiam  VolNum
3030801    0.0        0.0158506      10
*          Af         Ar             JunNum
3030901    0.0        0.0            9  
*          tlpvbfe                   VolNum
3031001    0000000                   10
*          Jefvcahs                  JunNum
3031101    00000000                  9
*          Ebt   Initial-Conditions             VolNum
3031201    003   137900.     908.0  0.  0.  0.  10
*          Vel/Mfr
3031300    1
*          Liquid  Vapor  Interface  JunNum
3031301    0.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
3031401    0.0        0.0       1.0   1.0    9
*
*
*********************************
*        outer core - outermost graphite channels
*       channels fuel flows through 
*         1/3 of chanels
*      * need to change to graphite?
*           Pipe - 304          *
*      our problem chile pipe?  our 304 pipe hahahahahahahahahahah
*********************************
*          Name     Type
3040000    core3    pipe
*          NumOfVolumes
3040001    10
*          Area                      VolNum
3040101    0.182099                  10
*          JunArea                   JunNum 
3040201    0.0                       9
*          Length                    VolNum
3040301    0.17018                   10
*          Volume                    VolNum
3040401    0.0                       10
*          AzimAng                   VolNum
3040501    0.0                       10
*          InclAng                   VolNum
3040601    90.0                      10
*          Roughness  HydraulicDiam  VolNum
3040801    0.0        0.0158506      10
*          Af         Ar             JunNum
3040901    0.0        0.0            9  
*          tlpvbfe                   VolNum
3041001    0000000                   10
*          Jefvcahs                  JunNum
3041101    00000000                  9
*          Ebt   Initial-Conditions             VolNum
3041201    003   137900.     908.0  0.  0.  0.  10
*          Vel/Mfr
3041300    1
*          Liquid  Vapor  Interface  JunNum
3041301    0.0     0.0    0.0        9
*          JunHydDia  Flooding  c     Slope  JunNum
3041401    0.0        0.0       1.0   1.0    9
*
*
*
*
*********************************
*   Branch/Sepatator - 305      *
* not done yet, need inlets and outlets 
*   page A7-59 in appendix A 
*   top of core, out of graphite chanels 
*    called "top head" in documentation
*
*    assuming volume and area are same as bottom head (component 301)
*   
*********************************
*          Name       Type 
3050000    tophead    branch
*          NumOfJunctions     Vel/Mfr
3050001    4                  0.0
*          Area        Length   Volume
3050101    1.11387     0.254    0.0
*          AzimAng  InclAng   ElevationChange
3050102    0.0      0.0       0.0
*          Roughness  HydraulicDiam  Tlpvbfe
3050103    0.0        0.0            0000000
*          Ebt       Initial-Conditions
3050200    003       137900.     908.0  

********************** start fixing from here3010200    003       137895.     908.15  
*          From       To         Area  Kt   Kr   Efvcahs   (ccc010000 = outlet, ccc000000=inlet)
3051101    305010000  102000000  0.0   0.0  0.0  0000000   
3052101    302010000  305000000  0.0   0.0  0.0  0000000   * junction from inner core/hottes point
3053101    303010000  305000000  0.0   0.0  0.0  0000000   * junction from mid temp region of core
3054101    304010000  305000000  0.0   0.0  0.0  0000000   * junction from outer core
*          Liquid    Vapor    Interface=enter0.0  (initial velocities) 301N201 page A7-59
3051201    1.0    0.0      0.0
3052201    1.0    0.0      0.0
3053201    1.0    0.0      0.0
3054201    1.0    0.0      0.0
*
*
*
*
*
*
*
*
*
*
*******************************************************************************
*                                                                             *
*                               Heat Structures                               *
*                                                                             *
*******************************************************************************
*
***************************************************************************
*    Main HX - 100
***************************************************************************
*           AxialHS  RadMesh  GeoType  SSFlag  LeftBound  Reflood  
11000000    20       2        2        1       0.0052832  0
*           MeshLocation     MeshFormat
11000100    0                1
*           NumOfIntervals   RightCoordinate
11000101    1                0.00635
*           CompositionNum   IntervalNum
11000201    1                1
*           SourceValue      IntervalNum
11000301    0.0              1 
*           InitialTemp      MeshPointNum
11000401    900.             2
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
11000501    200010000          10000   134     1       38.7706    20
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
11000601    104100000          -10000  101     1       38.7706    10
11000602    104010000          10000   101     1       38.7706    20
*           SourceType  Pf    LeftBoundMult   RightBoundMult  HSNum
11000701    0           0.0   0.0             0.0             20
*           WordFormat
11000800    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
11000801    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   20
*           WordFormat
11000900    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
11000901    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   20
*
************************************************************************************************************
*   Air HX - 200
************************************************************************************************************
*           AxialHS  RadMesh  GeoType  SSFlag  LeftBound  Reflood  
12000000    10       2        2        1       0.0080137   0
*           MeshLocation     MeshFormat
12000100    0                1
*           NumOfIntervals   RightCoordinate
12000101    1                0.0098425
*           CompositionNum   IntervalNum
12000201    1                1
*           SourceValue      IntervalNum
12000301    0.0              1 
*           InitialTemp      MeshPointNum
12000401    900.             2
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
12000501    204010000          10000   134     1       109.728    10
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
12000601    -100               0       1000    1       109.728    10
*           SourceType  Pf    LeftBoundMult   RightBoundMult  HSNum
12000701    0           0.0   0.0             0.0             10
*           WordFormat
12000800    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
12000801    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*
*********
*  CORE HEAT STRUCTURES
*********
*  Center core - 302
*********
*           AxialHS  RadMesh  GeoType  SSFlag  LeftBound  Reflood  
13020000    10       2        2        1       0.0        0
*           MeshLocation     MeshFormat
13020100    0                1
*           NumOfIntervals   RightCoordinate
13020101    1                0.001
*           CompositionNum   IntervalNum
13020201    111              1
*           SourceValue      IntervalNum
13020301    1.0              1 
*           InitialTemp      MeshPointNum
13020401    900.             2
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13020501    0                  0       0       1       100000.     10
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13020601    302010000          10000   110     1       100000.     10
*           SourceType  Pf         LeftBoundMult   RightBoundMult  HSNum
13020701    1           0.0215459  0.0             0.0             10
*           WordFormat
13020900    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13020901    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*
*********
*  Inner core - 303
*********
*           AxialHS  RadMesh  GeoType  SSFlag  LeftBound  Reflood  
13030000    10       2        2        1       0.0        0
*           MeshLocation     MeshFormat
13030100    0                1
*           NumOfIntervals   RightCoordinate
13030101    1                0.001
*           CompositionNum   IntervalNum
13030201    111              1
*           SourceValue      IntervalNum
13030301    1.0              1 
*           InitialTemp      MeshPointNum
13030401    900.             2
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13030501    0                  0       0       1       100000.     10
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13030601    303010000          10000   110     1       100000.     10
*           SourceType  Pf         LeftBoundMult   RightBoundMult  HSNum
13030701    1           0.0477788  0.0             0.0             10
*           WordFormat
13030900    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13030901    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*
*********
*  Outer core - 304
*********
*           AxialHS  RadMesh  GeoType  SSFlag  LeftBound  Reflood  
13040000    10       2        2        1       0.0        0
*           MeshLocation     MeshFormat
13040100    0                1
*           NumOfIntervals   RightCoordinate
13040101    1                0.001
*           CompositionNum   IntervalNum
13040201    111              1
*           SourceValue      IntervalNum
13040301    1.0              1 
*           InitialTemp      MeshPointNum
13040401    900.             2
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13040501    0                  0       0       1       100000.     10
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13040601    304010000          10000   110     1       100000.     10
*           SourceType  Pf         LeftBoundMult   RightBoundMult  HSNum
13040701    1           0.0306753  0.0             0.0             10
*           WordFormat
13040900    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13040901    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*
*********
*  CORE GRAPHITE HEAT STRUCTURES
*********
*  Center core - 312
*********
*           AxialHS  RadMesh  GeoType  SSFlag  LeftBound  Reflood  
13120000    10       2        2        1       0.0079253  0
*           MeshLocation     MeshFormat
13120100    0                1
*           NumOfIntervals   RightCoordinate
13120101    1                0.01
*           CompositionNum   IntervalNum
13120201    4                1
*           SourceValue      IntervalNum
13120301    0.0              1 
*           InitialTemp      MeshPointNum
13120401    900.             2
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13120501    302010000          10000   110     1       21.5561    10
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13120601    303010000          10000   110     1       21.5561     10
*           SourceType  Pf    LeftBoundMult   RightBoundMult  HSNum
13120701    0           0.0   0.0             0.0             10
*           WordFormat
13120800    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13120801    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*           WordFormat
13120900    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13120901    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*
*********
*  Inner core - 313
*********
*           AxialHS  RadMesh  GeoType  SSFlag  LeftBound  Reflood  
13130000    10       2        2        1       0.0079253  0
*           MeshLocation     MeshFormat
13130100    0                1
*           NumOfIntervals   RightCoordinate
13130101    1                0.01
*           CompositionNum   IntervalNum
13130201    4                1
*           SourceValue      IntervalNum
13130301    0.0              1 
*           InitialTemp      MeshPointNum
13130401    900.             2
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13130501    303010000          10000   110     1       64.6684     10
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13130601    304010000          10000   110     1       64.6684     10
*           SourceType  Pf    LeftBoundMult   RightBoundMult  HSNum
13130701    0           0.0   0.0             0.0             10
*           WordFormat
13130800    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13130801    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*           WordFormat
13130900    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13130901    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*
*********
*  Outer core - 314
*********
*           AxialHS  RadMesh  GeoType  SSFlag  LeftBound  Reflood  
13140000    10       2        2        1       0.70485    0
*           MeshLocation     MeshFormat
13140100    0                1
*           NumOfIntervals   RightCoordinate
13140101    1                0.7112
*           CompositionNum   IntervalNum
13140201    1                1
*           SourceValue      IntervalNum
13140301    0.0              1 
*           InitialTemp      MeshPointNum
13140401    900.             2
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13140501    304010000          10000   110     1       0.17018    10
*           BoundaryVol/Table  Incr    BCType  SACode  SA/Factor  HSNum
13140601    300100000          -10000  110     1       0.17018    10
*           SourceType  Pf    LeftBoundMult   RightBoundMult  HSNum
13140701    0           0.0   0.0             0.0             10
*           WordFormat
13140800    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13140801    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*           WordFormat
13140900    0
*           HydDiam  HLFor  HLRev  GSLFor  GSLRev  GLCFor  GLCRev  Boil  HSNum
13140901    0.0      3.0    3.0    0.0     0.0     0.0     0.0     1.0   10
*
*******************************************************************************
*                                                                             *
*                             General Table Data                              *
*                                                                             *
*******************************************************************************
* 
*   Right boundary of Air HX
*           TableType
20210000    temp
*           ArgValue   FunctionValue
20210001    0.0        824.82 
* Constantly 824.82 K
* 
*    Steady-state power table
*           TableType
20200100    power
*           ArgValue   FunctionValue
20200101    0.0        1.0e7
*
*******************************************************************************
*                                                                             *
*                            Thermal Property Data                            *
*                                                                             *
*******************************************************************************
* 
*******************************
*   INOR-8  AKA Hastelloy N   *
*******************************
*           MaterialType   ThermCondFlag   VolHeatCapFlag
20100100    tbl/fctn            1               1
*           Temperature    ThermalConductivity
20100101    553.15         16.11
20100102    573.15         16.45
20100103    593.15         16.79
20100104    613.15         17.17
20100105    633.15         17.47
20100106    653.15         17.76
20100107    673.15         18.09
20100108    693.15         18.43
20100109    713.15         18.75
20100110    733.15         19.04
20100111    753.15         19.30
20100112    773.15         19.58
20100113    793.15         19.94
20100114    813.15         20.16
20100115    833.15         20.43
20100116    853.15         20.82
20100117    873.15         21.70
20100118    893.15         23.16
20100119    913.15         24.86
20100120    933.15         26.04
20100121    953.15         26.64
20100122    973.15         26.21
20100123    993.15         26.99
20100124    1013.15        26.17
20100125    1033.15        25.05
20100126    1053.15        24.75
20100127    1073.15        25.00
20100128    2073.15        25.00
*           HeatCapacity (since only one word, assume constant)
20100151    5093660.
*
*           MaterialType
20100200    s-steel
20100300    c-steel
*
***************
*  Graphite
***************
*          MaterialType   ThermCondFlag   VolHeatCapFlag
20100400   tbl/fctn       1               1
*          ThermalConductivity
20100401   108.963
*          Temp        VolHeatCap
20100451   255.372     1089513.3
20100452   366.483     1712092.3
20100453   588.706     2568138.4
20100454   810.928     3035072.6
20100455   922.039     3268539.8
20100456   2000.0      3268539.8
*   Fake material (for core heat structures)
*           MaterialType   ThermCondFlag   VolHeatCapFlag
20111100   tbl/fctn            1               1
20111101   1e6
20111151   1e8
*
*
*******************************************************************************
*                                                                             *
*                                  Kinetics                                   *
*                                                                             *
*******************************************************************************
*
*           KineticsType      FeedbackType
30000000    point             separabl
*           Decay     Power    React   NFrac YFact  U239  Fissions  Time  Units
30000001    gamma-ac  1.0e+7  -1.e-60  15.   1.0    1.0   1.0       52.    wk
*           Type     E/Fiss
30000002    ans79-1  200.
*           Table/ContVarNum
* 30000011    601
*           ModeratorDensity    Reactivity
30000501    1936.82            -4.602823e-02
30000502    1958.02            -1.650823e-02
30000503    1979.22             1.301177e-02
30000504    2000.42             4.253177e-02
30000505    2021.62             7.205177e-02
30000506    2042.82             1.015718e-01
30000507    2064.02             1.310918e-01
30000508    2085.22             1.606118e-01
30000509    2106.42             1.901318e-01
30000510    2127.62             2.196518e-01
30000511    2148.82             2.491718e-01
*           Temperature         Reactivity
30000601    500.0               2.795586e-01
30000602    550.0               2.464386e-01
30000603    600.0               2.133186e-01
30000604    650.0               1.801986e-01
30000605    700.0               1.470786e-01
30000606    750.0               1.139586e-01
30000607    800.0               8.083857e-02
30000608    850.0               4.771857e-02
30000609    900.0               1.459857e-02
30000610    950.0              -1.852143e-02
30000611    1000.0             -5.164143e-02
* We need to sort out these sections
* 700 cards apply the 500 cards to hydrodynamic components
*           HydDiamNum  Incr    WeightFact  LiqTempCoef
30000701    302010000   10000   1.0         0.0
+ 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0
30000702    303010000   10000   1.0         0.0
+ 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0
30000703    304010000   10000   1.0         0.0
+ 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0
* 800 cards apply the 600 cards to heat structures
*           HSNum     Incr  WeightFact  FuelTempCoef
30000801    3120001   1     1.0         0.0
+ 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0
30000802    3130001   1     1.0         0.0
+ 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0
30000803    3140001   1     1.0         0.0
+ 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0 1.0 0.0
*
*
.