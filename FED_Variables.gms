*******************************************************************************
*---------------------Declare variables and equations--------------------------
*******************************************************************************

*******************Dispaching existing units************************************
*------------------VKA1 Heatpump related----------------------------------------

positive variable
         H_VKA1(h)         heating power available from VKA1
         C_VKA1(h)         cooling power available from VKA1
         el_VKA1(h)        electricity needed by VKA1
;
*------------------VKA4 Heatpump related----------------------------------------

positive variable
         H_VKA4(h)         heating power available from VKA4
         C_VKA4(h)         cooling power available from VKA4
         el_VKA4(h)        electricity needed by VKA4
;
*------------------AbsC(Absorbtion Chiller) related-----------------------------

positive variable
         q_AbsC(h)           heat demand for Absorbtion Chiller
         k_AbsC(h)           cooling power available in AbsC
         AbsC_cap            capacity of AbsC
;
AbsC_cap.fx=cap_sup_unit('AbsC');
*------------------Refrigerator Machine related---------------------------------

positive variable
         e_RM(h)           electricity demand for refrigerator
         k_RM(h)           cooling power available from the refrigerator
         RM_cap            capacity of refrigerator
;
*this is the aggregated capacity of five exisiting RM Units
RM_cap.fx=cap_sup_unit('RM');
*------------------MC2 Refrigerator Machine related-----------------------------
positive variable
         e_RMMC(h)          electricity demand for refrigerators
         k_RMMC(h)          cooling power available from refrigerators
;
binary variable
         RMMC_inv           decision variable for MC2 connection investment
;

*------------------Abient Air Cooling Machine related---------------------------

positive variable
         e_AAC(h)           electricity demand for refrigerator
         k_AAC(h)           cooling power available from the refrigerator
         AAC_cap            capacity of refrigerator
;
AAC_cap.fx=cap_sup_unit('AAC');
******************New investments***********************************************
*----------------Panna 2 related -----------------------------------------------
positive variable
         q_P2(h)           fuel demand in P2
         H_P2(h)           generated heating in P2
;
binary variable
         B_P2              Decision variable for P2 investment
;
*----------------Refurbished turbine for Panna 2  ------------------------------
positive variable
         e_TURB(h)         electricity generated in turbine-gen
         q_TURB(h)         steam demand in turbine
         H_P2T(h)            steam generated in P2-turb combo
;
binary variable
         B_TURB            Decision variable for turbine investment
;

*------------------HP related---------------------------------------------------

positive variable
         q_HP(h)           heating power available in HP
         c_HP(h)           cooling power available from HP
         e_HP(h)           electricity needed by the HP
         HP_cap            capacity of HP
;
*------------------TES related--------------------------------------------------

positive variable
         TES_ch(h)         input to the TES-chargin the TES
         TES_dis(h)        output from the TES-discharging the TES
         TES_en(h)         energy content of TES at any instant
         TES_cap           capacity of the TES in m3
;
*TES_cap.up=380;
binary variable
         TES_inv          Decision variable for Accumulator investment
;
*------------------BITES (Building energy storage) related----------------------

positive variable
         BTES_Sch(h,i)    charing rate of shallow section of the building
         BTES_Sdis(h,i)   dischargin rate of shallow section of the building
         BTES_Sen(h,i)    energy stored in the shallow section of the building
         BTES_Den(h,i)    energy stored in the deep section of the building
         BTES_Sloss(h,i)  heat loss from the shallow section of the building
         BTES_Dloss(h,i)  heat loss from the deep section of the building
;
variable
         link_BS_BD(h,i)  heat flow between the shallow and the deep section
;
binary variable
         B_BITES(i)       Decision variable weither to invest BITES control sys-
;
*Buildings with BITES capability
B_BITES.fx('2')=0;
B_BITES.fx('5')=0;
B_BITES.fx('7')=0;
B_BITES.fx('18')=0;
B_BITES.fx('24')=0;
B_BITES.fx('25')=0;
B_BITES.fx('26')=0;
*----------------Solar PV PV relate variables-----------------------------------

positive variable
         e_PV(h)    elecricity produced by PV
         PV_cap     capacity of solar panal
;
*------------------Battery related----------------------------------------------

positive variables
         BES_en(h)       Energy stored in the battry at time t and building i
         BES_ch(h)       Battery charing at time t and building i
         BES_dis(h)      Battery discharging at time t and building i
         BES_cap        Capacity of the battery at building i
;
*------------------Grid El related----------------------------------------------

variable
         e_exG(h)           electrical power input from grid
;
e_exG.lo(h)=0;
*------------------Grid DH related----------------------------------------------

variable
         q_DH(h)            heat power input from grid
;
q_DH.lo(h)=0;
*------------------Grid DC related---------------------------------------------

variable
         P_DC(h)             cooling from district cooling system
;
P_DC.fx(h)=0;
*-------------------------PE and CO2 related -----------------------------------

positive variables
         FED_PE         Primery energy limit of the FED system
         FED_CO2(h)     CO2 limit of the FED system
;

FED_PE.up=PE_lim;
FED_CO2.up(h)=CO2_lim;
*--------------------Objective function-----------------------------------------

variable
         TC                   total cost
         invCost              total investment cost
;
