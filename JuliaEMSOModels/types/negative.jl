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
export negative
typealias Dananegative DanaRealParametric
type _negative
	function _negative(_::Dict{Symbol,Any})
		fields::Dict{Symbol,Any}=(Symbol=>Any)[]
		fields[:Brief]="Negative General Constant"
		fields[:Default]=-1.0
		fields[:Upper]=1e-6
		drive!(fields,_)
		new(fields)
	end
	value::Dict{Symbol,Any}
end
typealias negative DanaRealParametric{_negative}