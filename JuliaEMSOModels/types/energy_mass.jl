#-------------------------------------------------------------------
#* EMSO Model Library (EML) Copyright (C) 2004 - 2007 ALSOC.
#*
#* This LIBRARY is free software; you can distribute it and/or modify
#* it under the therms of the ALSOC FREE LICENSE as available at
#* http://www.enq.ufrgs.br/alsoc.
#*
#* EMSO Copyright (C) 2004 - 2007 ALSOC, original code
#* from http://www.rps.eng.br Copyright (C) 2002-2004.
#* All rights reserved.
#*
#* EMSO is distributed under the therms of the ALSOC LICENSE as
#* available at http://www.enq.ufrgs.br/alsoc.
#*
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
#----------------------------------------------------------------------------------*
#*
#*-------------------------  Fundamental Variables ----------------------------------*
#*
#*----------------------------------------------------------------------------------
# Constants
# Pressure
# Temperature
# Time
# Size related
# Eletric
# Currency
#----------------------------------------------------------------------------------*
#*
#*-------------------------  Concentration Related ----------------------------------*
#*
#*----------------------------------------------------------------------------------
# elementary
#mol as positive (Brief = "Moles", Default=2500, Upper=1e9, final Unit = 'mol');
# densities
# Concentration
# reaction
#----------------------------------------------------------------------------------*
#*
#*------------------------- Thermodynamics Properties -------------------------------*
#*
#*----------------------------------------------------------------------------------
# Heat Capacity
# Enthalpy
# Entropy
# Heat
# Energy
export energy_mass
typealias Danaenergy_mass DanaRealParametric
type _energy_mass
	function _energy_mass(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
		fields[:Brief]="Energy per mass"
		fields[:Default]=10000
		fields[:Lower]=-1e15
		fields[:Upper]=1e15
		fields[:finalUnit]="kJ/kg"
		drive!(fields,_)
		new(fields)
	end
	value::Dict{Symbol,Any}
end
typealias energy_mass DanaRealParametric{_energy_mass}