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
#* Authors: Rafael de Pelegrini Soares
#*          Andrey Copat, Estefane S. Horn, Marcos L. Alencastro
#* $Id$
#*--------------------------------------------------------------------
#Needs to be reformulated
type HidraulicTurbine
	HidraulicTurbine()=begin
		NComp=outers.NComp
		PP=outers.PP
		new(
			DanaInteger (Dict{Symbol,Any}(
				:Brief=>"Number of chemical components",
				:Lower=>1
			)),
			DanaPlugin (Dict{Symbol,Any}(
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			)),
			fill(molweight (Dict{Symbol,Any}(
				:Brief=>"Molar Weight"
			)),(NComp)),
			efficiency (Dict{Symbol,Any}(
				:Brief=>"Turbine efficiency"
			)),
			efficiency (Dict{Symbol,Any}(
				:Brief=>"Brake efficiency"
			)),
			positive (Dict{Symbol,Any}(
				:Brief=>"Volumetric expansivity",
				:Unit=>"1/K"
			)),
			head (Dict{Symbol,Any}(
				:Brief=>"Head Developed"
			)),
			power (Dict{Symbol,Any}(
				:Brief=>"Fluid Power"
			)),
			power (Dict{Symbol,Any}(
				:Brief=>"Brake Power"
			)),
			positive (Dict{Symbol,Any}(
				:Brief=>"Pressure Ratio"
			)),
			press_delta (Dict{Symbol,Any}(
				:Brief=>"Pressure Drop",
				:DisplayUnit=>"kPa",
				:Symbol=>"\\Delta P"
			)),
			molweight (Dict{Symbol,Any}(
				:Brief=>"Mixture Molar Weight"
			)),
			dens_mass (Dict{Symbol,Any}(
				:Brief=>"Specific Mass"
			)),
			cp_mol (Dict{Symbol,Any}(
				:Brief=>"Heat Capacity"
			)),
			stream (Dict{Symbol,Any}(
				:Brief=>"Inlet stream",
				:PosX=>0.05,
				:PosY=>0.0,
				:Symbol=>"_{in}"
			)),
			stream (Dict{Symbol,Any}(
				:Brief=>"Outlet stream",
				:PosX=>0.65,
				:PosY=>1,
				:Symbol=>"_{out}"
			)),
			power (Dict{Symbol,Any}(
				:Brief=>"Work Outlet",
				:PosX=>1,
				:PosY=>0.46
			)),
			[
				:(Mwm = sum(Mw*Inlet.z)),
				:(rho = PP.LiquidDensity(Inlet.T,Inlet.P,Inlet.z)),
				:(Outlet.v = PP.VapourFraction(Outlet.T, Outlet.P, Outlet.z)),
				:(Cp = PP.LiquidCp(Inlet.T,Inlet.P,Inlet.z)),
				:(Outlet.P = Inlet.P * Pratio),
				:(Outlet.P = Inlet.P - Pdrop),
				:(FPower * rho = -Pdrop * Inlet.F * Mwm),
				:(BPower = FPower * Eff),
				:(BPower = WorkOut),
				:((Outlet.T - Inlet.T) * rho * Cp = (Outlet.h - Inlet.h) * rho + Pdrop * Mwm * (1-Beta*Inlet.T)),
				:((Outlet.h - Inlet.h) * rho = -Pdrop * Mwm),
				:(Outlet.F = Inlet.F),
				:(Outlet.z = Inlet.z),
				:(Head = Outlet.h - Inlet.h),
			],
			[
				"Calculate Mwm for Inlet Mixture","Calculate rho using a External Physical Properties Routine","Calculate Outlet Vapour Fraction","Calculate Cp Using a External Physical Properties Routine","Pressure Ratio","Pressure Drop","Calculate Fluid Power","Calculate Brake Power","","Calculate Outlet Temperature","Calculate Outlet Enthalpy","Molar Balance","Calculate Outlet Composition","Calculate Head",
			],
			[:NComp,:PP,:Mw,],
			[:Eff,:Meff,:Beta,:Head,:FPower,:BPower,:Pratio,:Pdrop,:Mwm,:rho,:Cp,:Inlet,:Outlet,:WorkOut,]
		)
	end
	NComp::DanaInteger 
	PP::DanaPlugin 
	Mw::Array{molweight }
	Eff::efficiency 
	Meff::efficiency 
	Beta::positive 
	Head::head 
	FPower::power 
	BPower::power 
	Pratio::positive 
	Pdrop::press_delta 
	Mwm::molweight 
	rho::dens_mass 
	Cp::cp_mol 
	Inlet::stream 
	Outlet::stream 
	WorkOut::power 
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export HidraulicTurbine
function set(in::HidraulicTurbine)
	Mw = PP.MolecularWeight()
	 
end
function setEquationFlow(in::HidraulicTurbine)
	#Mixtures Properties
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
	addEquation(14)
end
function atributes(in::HidraulicTurbine,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/HidraulicTurbine"
	fields[:Brief]="Testing Model of a Hidraulic Turbine."
	drive!(fields,_)
	return fields
end
HidraulicTurbine(_::Dict{Symbol,Any})=begin
	newModel=HidraulicTurbine()
	newModel.attributes=atributes(newModel,_)
	newModel
end
