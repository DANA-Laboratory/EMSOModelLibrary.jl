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
export dens_mass
typealias Danadens_mass DanaRealParametric
type _dens_mass
	function _dens_mass(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
		fields[:Brief]="Mass Density"
		fields[:Default]=1000
		fields[:Lower]=-1e-20
		fields[:Upper]=5e8
		fields[:finalUnit]="kg/m^3"
		drive!(fields,_)
		new(fields)
	end
	value::Dict{Symbol,Any}
end
typealias dens_mass DanaRealParametric{_dens_mass}