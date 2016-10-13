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
#* Models to simulate a power plant.
#*--------------------------------------------------------------------
#* Author: Argimiro R. Secchi
#* $Id: power_plant.mso 195 2007-03-07 20:30:12Z arge $
#*-------------------------------------------------------------------
# Declaracao de tipos
type Fonte2
	Fonte2()=begin
		PP2=outers.PP2
		new(
			DanaPlugin(Dict{Symbol,Any}(
				:Brief=>"Steam tables"
			)),
			Corrente(Dict{Symbol,Any}(
				:Symbol=>"_{out}",
				:PosX=>1,
				:PosY=>0.5
			)),
			[
				:([Fout.S,Fout.H] = PP2.propPTl(Fout.P,Fout.T)),
			],
			[
				"",
			],
			[:PP2,],
			[:Fout,]
		)
	end
	PP2::DanaPlugin
	Fout::Corrente
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Fonte2
function setEquationFlow(in::Fonte2)
	addEquation(1)
end
function atributes(in::Fonte2,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/fonte2"
	fields[:Brief]="Corrente de sa죡da"
	fields[:Info]=" "
	drive!(fields,_)
	return fields
end
Fonte2(_::Dict{Symbol,Any})=begin
	newModel=Fonte2()
	newModel.attributes=atributes(newModel,_)
	newModel
end
