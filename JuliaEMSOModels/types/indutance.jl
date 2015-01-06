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
export indutance
typealias Danaindutance Danapositive
type _indutance
	function _indutance(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=(Symbol=>Any)[]
		fields[:Brief]="Electrical Indutance"
		fields[:Default]=10
		fields[:Upper]=1e12
		fields[:finalUnit]="V*s/A"
		drive!(fields,_)
		new(_positive (fields).value)
	end
	value::Dict{Symbol,Any}
end
typealias indutance Danapositive{_indutance}