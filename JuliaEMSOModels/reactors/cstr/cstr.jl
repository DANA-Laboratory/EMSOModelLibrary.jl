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
#*--------------------------------------------------------------------
#* Model of cstr reactor
#*--------------------------------------------------------------------
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
type cstr
	cstr()=begin
		new(
			cstr_basic(),
			fill(reaction_mol(Dict{Symbol,Any}(
				:Brief=>"Molar Reaction Rate"
			)),(NReac)),
			fill(heat_reaction(Dict{Symbol,Any}(
				:Brief=>"Heat Reaction"
			)),(NReac)),
			[
				:(diff(_base_1.Outlet.z*M) = (_base_1.Inlet.F*_base_1.Inlet.z - _base_1.Outlet.F*_base_1.Outlet.z) + sumt(_base_1.stoic*r)*_base_1.Vr),
				:(diff(M*_base_1.Outlet.h) = _base_1.Inlet.F*_base_1.Inlet.h - _base_1.Outlet.F*_base_1.Outlet.h +sum(Hr*sum(_base_1.stoic*r))*_base_1.Vr - q),
			],
			[
				"Component Molar Balance","Reactor Energy Balance",
			],
			[:r,:Hr,]
		)
	end
	_base_1::cstr_basic
	r::Array{reaction_mol}
	Hr::Array{heat_reaction}
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export cstr
function setEquationFlow(in::cstr)
	addEquation(1)
	addEquation(2)
	#FIXME sum(sum())
	
end
function atributes(in::cstr,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/cstr"
	fields[:Brief]="Model of a generic CSTR"
	fields[:Info]="
Requires the information of:
* Reaction values
* Heat of reaction
"
	drive!(fields,_)
	return fields
end
cstr(_::Dict{Symbol,Any})=begin
	newModel=cstr()
	newModel.attributes=atributes(newModel,_)
	newModel
end
