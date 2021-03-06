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
#*----------------------------------------------------------------------
#* Author: Paula B. Staudt
#* $Id$
#*--------------------------------------------------------------------
type TankL
	TankL()=begin
		PP=outers.PP
		NComp=outers.NComp
		[
			:(LI = Levelpercent_Initial),
			:(OutletLiquid.T = Temperature_Initial),
			:(OutletLiquid.z(1:NComp - 1) = Composition_Initial(1:NComp - 1)/sum(Composition_Initial)),
		],
		[
			"Initial level Percent","Initial Outlet Liquid Temperature","Initial Outlet Liquid Composition Normalized",
		],
		new(
			DanaPlugin(Dict{Symbol,Any}(
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			)),
			DanaInteger(Dict{Symbol,Any}(
				:Brief=>"Number of components",
				:Lower=>1
			)),
			acceleration(Dict{Symbol,Any}(
				:Brief=>"Gravity Acceleration",
				:Default=>9.81,
				:Hidden=>true
			)),
			flow_mol(Dict{Symbol,Any}(
				:Brief=>"Low Flow",
				:Default=>1E-6,
				:Hidden=>true
			)),
			flow_mol(Dict{Symbol,Any}(
				:Brief=>"No Flow",
				:Default=>0,
				:Hidden=>true
			)),
			DanaReal(Dict{Symbol,Any}(
				:Brief=>"Constant for K factor pressure drop",
				:Unit=>"mol/(s*(Pa^0.5))",
				:Default=>1,
				:Hidden=>true
			)),
			positive(Dict{Symbol,Any}(
				:Brief=>"K factor for pressure drop",
				:Lower=>1E-8,
				:Default=>2
			)),
			DanaSwitcher(Dict{Symbol,Any}(
				:Brief=>"Normal Flow",
				:Valid=>["on", "off"],
				:Default=>"on",
				:Hidden=>true
			)),
			positive(Dict{Symbol,Any}(
				:Brief=>"Initial liquid height in Percent",
				:Default=>0.70
			)),
			temperature(Dict{Symbol,Any}(
				:Brief=>"Initial Liquid Temperature",
				:Default=>330
			)),
			fill(fraction(Dict{Symbol,Any}(
				:Brief=>"Initial Composition",
				:Default=>0.10
			)),(NComp)),
			VesselVolume(Dict{Symbol,Any}(
				:Brief=>"Vessel Geometry",
				:Symbol=>" "
			)),
			stream(Dict{Symbol,Any}(
				:Brief=>"Feed Stream",
				:PosX=>0.22,
				:PosY=>0,
				:Symbol=>"_{in}"
			)),
			liquid_stream(Dict{Symbol,Any}(
				:Brief=>"Liquid outlet stream",
				:PosX=>0.43,
				:PosY=>1,
				:Symbol=>"_{out}^{Liquid}"
			)),
			power(Dict{Symbol,Any}(
				:Brief=>"Heat Duty",
				:PosX=>0.735,
				:PosY=>1,
				:Protected=>true,
				:Symbol=>"Q_{in}"
			)),
			fill(mol(Dict{Symbol,Any}(
				:Brief=>"Molar Holdup in the Vessel",
				:Protected=>true
			)),(NComp)),
			energy(Dict{Symbol,Any}(
				:Brief=>"Total Energy Holdup in the Vessel",
				:Protected=>true
			)),
			volume_mol(Dict{Symbol,Any}(
				:Brief=>"Liquid Molar Volume",
				:Protected=>true
			)),
			pressure(Dict{Symbol,Any}(
				:Brief=>"Static head at the bottom of the tank",
				:Protected=>true,
				:Symbol=>"P_{static}^{Liquid}"
			)),
			control_signal(Dict{Symbol,Any}(
				:Brief=>"Temperature Indicator",
				:PosX=>0.525,
				:PosY=>0,
				:Protected=>true
			)),
			control_signal(Dict{Symbol,Any}(
				:Brief=>"Pressure Indicator",
				:PosX=>0.368,
				:PosY=>0,
				:Protected=>true
			)),
			control_signal(Dict{Symbol,Any}(
				:Brief=>"Level Indicator",
				:PosX=>1,
				:PosY=>0.6,
				:Protected=>true
			)),
			[
				:(diff(TotalHoldup)=Inlet.F*Inlet.z - OutletLiquid.F*OutletLiquid.z),
				:(diff(E) = Inlet.F*Inlet.h - OutletLiquid.F*OutletLiquid.h + InletQ),
				:(E = sum(TotalHoldup)*OutletLiquid.h),
				:(Pstatic = PP.LiquidDensity(OutletLiquid.T, Inlet.P, OutletLiquid.z) * Gconst * Geometry.Level),
				:(Inlet.P + Pstatic = OutletLiquid.P),
				:(vL = PP.LiquidVolume(OutletLiquid.T, OutletLiquid.P, OutletLiquid.z)),
				:(TotalHoldup = OutletLiquid.z*sum(TotalHoldup)),
				:(Geometry.Vfilled = sum(TotalHoldup) * vL),
				:(TI * "K" = OutletLiquid.T),
				:(PI * "atm" = OutletLiquid.P),
				:(LI*Geometry.Vtotal= Geometry.Vfilled),
			],
			[
				"Component Molar Balance","Energy Balance","Energy Holdup","Static Head","Mechanical Equilibrium","Liquid Volume","Molar Holdup","Liquid Level","Temperature indicator","Pressure indicator","Level indicator",
			],
			[:PP,:NComp,:Gconst,:low_flow,:zero_flow,:KfConst,:Kfactor,:NormalFlow,:Levelpercent_Initial,:Temperature_Initial,:Composition_Initial,],
			[:Geometry,:Inlet,:OutletLiquid,:InletQ,:TotalHoldup,:E,:vL,:Pstatic,:TI,:PI,:LI,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Gconst::acceleration
	low_flow::flow_mol
	zero_flow::flow_mol
	KfConst::DanaReal
	Kfactor::positive
	NormalFlow::DanaSwitcher
	Levelpercent_Initial::positive
	Temperature_Initial::temperature
	Composition_Initial::Array{fraction}
	Geometry::VesselVolume
	Inlet::stream
	OutletLiquid::liquid_stream
	InletQ::power
	TotalHoldup::Array{mol}
	E::energy
	vL::volume_mol
	Pstatic::pressure
	TI::control_signal
	PI::control_signal
	LI::control_signal
	initials::Array{Expr,1}
	initialNames::Array{String,1}
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export TankL
function set(in::TankL)
	Gconst = 9.81 * "m/(s^2)"
	 low_flow = 1E-6 * "kmol/h"
	 zero_flow = 0 * "kmol/h"
	 KfConst = 1*"mol/(s*(Pa^0.5))"
	 
end
function initial(in::TankL)
	addEquation(1)
	addEquation(2)
	addEquation(3)
end
function setEquationFlow(in::TankL)
	#
#switch NormalFlow
#
#case "on":
#	Inlet.F = Kfactor *sqrt(Pstatic)*KfConst;
#
#	when Inlet.F < low_flow switchto "off";
#
#case "off":
#	Inlet.F = zero_flow;
#
#	when Inlet.P > OutletLiquid.P switchto "on";
#
#end
#
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
end
function atributes(in::TankL,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/TankL"
	fields[:Brief]="Model of a Tank."
	fields[:Info]="== ASSUMPTIONS ==
* liquid phase only;

== SET ==
*Orientation: vessel position - vertical or horizontal;
*Heads (bottom and top heads are identical)
**elliptical: 2:1 elliptical heads (25% of vessel diameter);
**hemispherical: hemispherical heads (50% of vessel diameter);
**flat: flat heads (0% of vessel diameter);
*Diameter: Vessel diameter;
*Lenght: Side length of the cylinder shell;
	
== SPECIFY ==
* the Inlet stream;
* the OutletLiquid.F;
* the InletQ (the model requires an energy stream, also you can use a controller for setting the heat duty using the heat_flow model).

== OPTIONAL ==
* the TankL model has three control ports
** TI OutletLiquid Temperature Indicator;
** PI OutletLiquid Pressure Indicator;
** LI Level Indicator;

== INITIAL CONDITIONS ==
* Initial_Temperature :  the Tank temperature (OutletLiquid.T);
* Levelpercent_Initial : the Tank liquid level in percent (LI);
* Initial_Composition : (NoComps) OutletLiquid compositions.
"
	drive!(fields,_)
	return fields
end
TankL(_::Dict{Symbol,Any})=begin
	newModel=TankL()
	newModel.attributes=atributes(newModel,_)
	newModel
end
