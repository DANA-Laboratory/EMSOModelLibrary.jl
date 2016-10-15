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
#*--------------------------------------------------------------------
#* Author: Tiago Os򱨯rio
#* $Id$
#*-------------------------------------------------------------------
type FirstOrder
	FirstOrder()=begin
		new(
			DanaReal(Dict{Symbol,Any}(
				:Brief=>"Time Constant",
				:Unit=>"s",
				:Default=>4
			)),
			DanaReal(Dict{Symbol,Any}(
				:Unit=>"1/s"
			)),
			DanaReal(Dict{Symbol,Any}(
				:Unit=>"1/s"
			)),
			DanaReal(),
			DanaReal(Dict{Symbol,Any}(
				:Default=>0
			)),
			control_signal(Dict{Symbol,Any}(
				:Brief=>"State"
			)),
			control_signal(Dict{Symbol,Any}(
				:Brief=>"Input signal",
				:PosX=>0,
				:PosY=>0.5
			)),
			control_signal(Dict{Symbol,Any}(
				:Brief=>"Output signal",
				:PosX=>1,
				:PosY=>0.5
			)),
			[
				:(diff(x) = A*x + B*u),
				:(y = C*x + D*u),
			],
			[
				"","",
			],
			[:tau,:A,:B,:C,:D,],
			[:x,:u,:y,]
		)
	end
	tau::DanaReal 
	A::DanaReal 
	B::DanaReal 
	C::DanaReal
	D::DanaReal
	x::control_signal
	u::control_signal
	y::control_signal
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export FirstOrder
function setEquationFlow(in::FirstOrder)
	addEquation(1)
	addEquation(2)
end
function atributes(in::FirstOrder,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=false
	fields[:Icon]="icon/PIDIncr"
	drive!(fields,_)
	return fields
end
FirstOrder(_::Dict{Symbol,Any})=begin
	newModel=FirstOrder()
	newModel.attributes=atributes(newModel,_)
	newModel
end
