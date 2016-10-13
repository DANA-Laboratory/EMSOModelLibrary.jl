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
type StepSignal
	StepSignal()=begin
		new(
			positive(Dict{Symbol,Any}(
				:Unit=>"s"
			)),
			control_signal(),
			control_signal(),
			control_signal(Dict{Symbol,Any}(
				:PosX=>1,
				:PosY=>0.5
			)),
			[
				:(OutSignal = StartValue),
				:(OutSignal = FinalValue),
			],
			[
				"","",
			],
			[:StepTime,:StartValue,:FinalValue,],
			[:OutSignal,]
		)
	end
	StepTime::positive
	StartValue::control_signal
	FinalValue::control_signal
	OutSignal::control_signal
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export StepSignal
function setEquationFlow(in::StepSignal)
	if(time < StepTime) 
		addEquation(1)
	else
		addEquation(2)
	end
end
function atributes(in::StepSignal,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/StepSignal"
	drive!(fields,_)
	return fields
end
StepSignal(_::Dict{Symbol,Any})=begin
	newModel=StepSignal()
	newModel.attributes=atributes(newModel,_)
	newModel
end
