# -------------------------------------------------------------------
#* Distillation Column model with:
#*
#*	- NTrays like tray;
#*	- a vessel in the bottom of column;
#*	- a splitter who separate the bottom product and the stream to reboiler;
#*	- steady state reboiler (thermosyphon);
#*	- a steady state condenser with subcooling;
#*	- a vessel drum (layed cilinder);
#*	- a splitter which separate reflux and distillate;
#*	- a pump in reflux stream.
#*
#* ------------------------------------------------------------------
type Distillation_thermosyphon_subcooling
	Distillation_thermosyphon_subcooling()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin(Dict{Symbol,Any}(
				:Brief=>"External Physical Properties",
				:Type=>"PP"
			)),
			DanaInteger(),
			DanaInteger(Dict{Symbol,Any}(
				:Brief=>"Number of trays",
				:Default=>2
			)),
			DanaInteger(Dict{Symbol,Any}(
				:Brief=>"Trays counting (1=top-down, -1=bottom-up)",
				:Default=>1
			)),
			DanaInteger(Dict{Symbol,Any}(
				:Brief=>"Number of top tray"
			)),
			DanaInteger(Dict{Symbol,Any}(
				:Brief=>"Number of bottom tray"
			)),
			DanaSwitcher(Dict{Symbol,Any}(
				:Valid=>["on", "off"],
				:Default=>"on"
			)),
			fill(tray()),
			condenserSteady(),
			reboilerSteady(),
			tank(),
			tank_cylindrical(),
			splitter(),
			splitter(),
			pump(),
			DanaReal(),
			[
				:(cond.InletV.F*trays(top).vV = alfaTopo * trays(top).Ah * sqrt(2*(trays(top).OutletV.P - cond.OutletL.P + 1e-8 * "atm") / (trays(top).alfa*trays(top).rhoV))),
				:(cond.InletV.F = 0 * "mol/s"),
			],
			[
				"","",
			],
			[:PP,:NComp,:NTrays,:topdown,:top,:bot,:VapourFlow,],
			[:trays,:cond,:reb,:tbottom,:ttop,:spbottom,:sptop,:pump1,:alfaTopo,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	NTrays::DanaInteger
	topdown::DanaInteger
	top::DanaInteger
	bot::DanaInteger
	VapourFlow::DanaSwitcher
	trays::Array{tray}
	cond::condenserSteady
	reb::reboilerSteady
	tbottom::tank
	ttop::tank_cylindrical
	spbottom::splitter
	sptop::splitter
	pump1::pump
	alfaTopo::DanaReal
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export Distillation_thermosyphon_subcooling
function set(in::Distillation_thermosyphon_subcooling)
	top = (NTrays-1)*(1-topdown)/2+1
	 bot = NTrays/top
	 
end
function setEquationFlow(in::Distillation_thermosyphon_subcooling)
	let switch=VapourFlow
		if VapourFlow==cond.InletV.F < 1e-6 * "kmol/h"
			set(switch,"off")
		end
		if VapourFlow==trays(top).OutletV.P > cond.OutletL.P + 1e-1 * "atm"
			set(switch,"on")
		end
		if switch=="on"
			addEquation(1)
		elseif switch=="off"
			addEquation(2)
		end
	end
end
function atributes(in::Distillation_thermosyphon_subcooling,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Pallete]=true
	fields[:Icon]="icon/DistillationThermosyphonSubcooling"
	fields[:Brief]="Model of a distillation column with steady condenser and steady reboiler."
	fields[:Info]="== Specify ==
* the feed stream of each tray (Inlet);
* the Murphree eficiency for each tray Emv;
* the pump head;
* the condenser pressure drop;
* the heat supllied in top and bottom tanks;
* the heat supllied in condenser and reboiler;
* the Outlet1 flow in the bottom splitter (spbottom.Outlet1.F) that corresponds to the bottom product;
* both  top splitter outlet flows OR one of the splitter outlet flows and the splitter frac.
	
== Initial Conditions ==
* the trays temperature (OutletL.T);
* the trays liquid level (Level) OR the trays liquid flow (OutletL.F);
* (NoComps - 1) OutletL (OR OutletV) compositions for each tray;
	
* the top tank temperature (OutletL.T);
* the top tank liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions;
	
* the bottom tank temperature (OutletL.T);
* the bottom tank liquid level (Level);
* (NoComps - 1) OutletL (OR OutletV) compositions.
"
	drive!(fields,_)
	return fields
end
Distillation_thermosyphon_subcooling(_::Dict{Symbol,Any})=begin
	newModel=Distillation_thermosyphon_subcooling()
	newModel.attributes=atributes(newModel,_)
	newModel
end
