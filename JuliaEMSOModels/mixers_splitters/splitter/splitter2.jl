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
#* Author: Maur좩cio Carvalho Maciel, Paula B. Staudt, Rafael P. Soares
#* $Id$
#*--------------------------------------------------------------------
type splitter2
	splitter2()=begin
		new(
			stream(Dict{Symbol,Any}(
				:Brief=>"Inlet stream",
				:PosX=>0.5,
				:PosY=>0,
				:Symbol=>"_{in}"
			)),
			stream(Dict{Symbol,Any}(
				:Brief=>"Outlet stream 1",
				:PosX=>0.25,
				:PosY=>1,
				:Symbol=>"_{out1}"
			)),
			stream(Dict{Symbol,Any}(
				:Brief=>"Outlet stream 2",
				:PosX=>0.75,
				:PosY=>1,
				:Symbol=>"_{out2}"
			)),
			fill(fraction(Dict{Symbol,Any}(
				:Brief=>"Distribution of Outlets",
				:Default=>0.33,
				:Symbol=>"\\phi"
			)),(2)),
			[
				:(sum(FlowRatios) = 1),
				:(Outlet1.F = Inlet.F * FlowRatios(1)),
				:(Outlet1.F + Outlet2.F = Inlet.F),
				:(Outlet1.z = Inlet.z),
				:(Outlet2.z = Inlet.z),
				:(Outlet1.P = Inlet.P),
				:(Outlet2.P = Inlet.P),
				:(Outlet1.h = Inlet.h),
				:(Outlet2.h = Inlet.h),
				:(Outlet1.T = Inlet.T),
				:(Outlet2.T = Inlet.T),
				:(Outlet1.v = Inlet.v),
				:(Outlet2.v = Inlet.v),
			],
			[
				"Normalize Flow Ratios","Flow","","Composition","","Pressure","","Enthalpy","","Temperature","","Vapourisation Fraction","",
			],
			[:Inlet,:Outlet1,:Outlet2,:FlowRatios,]
		)
	end
	Inlet::stream
	Outlet1::stream
	Outlet2::stream
	FlowRatios::Array{fraction}
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export splitter2
function setEquationFlow(in::splitter2)
	addEquation(1)
	addEquation(2)
	addEquation(3)
	addEquation(4)
	addEquation(5)
	addEquation(6)
	addEquation(7)
	addEquation(8)
	addEquation(9)
	addEquation(10)
	addEquation(11)
	addEquation(12)
	addEquation(13)
end
function atributes(in::splitter2,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/splitter_column"
	fields[:Brief]="Splitter with 2 outlet streams"
	fields[:Info]="== Assumptions ==
*Thermodynamics equilibrium
*Adiabatic
			
== Specify ==
* The inlet stream
* One FlowRatios of split of the outlet streams:

	FlowRatios(i) = (Mole Flow of the outlet stream i / 
				Mole Flow of the inlet stream)
				where i = 1, 2
"
	drive!(fields,_)
	return fields
end
splitter2(_::Dict{Symbol,Any})=begin
	newModel=splitter2()
	newModel.attributes=atributes(newModel,_)
	newModel
end
