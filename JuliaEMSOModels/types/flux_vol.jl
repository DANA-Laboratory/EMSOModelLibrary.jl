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
#----------------------------------------------------------------------------------*
#*
#*--------------------------- Mass Transport ----------------------------------------*
#*
#*----------------------------------------------------------------------------------
# Flow
# Flux
export flux_vol
typealias Danaflux_vol Danapositive
type _flux_vol
	function _flux_vol(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
		fields[:Brief]="Volumetric Flux"
		fields[:Default]=1
		fields[:Upper]=1e4
		fields[:finalUnit]="m^3/s/m^2"
		drive!(fields,_)
		new(_positive(fields).value)
	end
	value::Dict{Symbol,Any}
end
typealias flux_vol Danapositive{_flux_vol}