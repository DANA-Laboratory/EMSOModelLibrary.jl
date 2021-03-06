#---------------------------------------------------------------------
#*	liquid and vapour phases
#*--------------------------------------------------------------------
type tank_liqvap
	tank_liqvap()=begin
		PP=outers.PP
		NComp=outers.NComp
		new(
			DanaPlugin(Dict{Symbol,Any}(
				:Brief=>"External physical properties",
				:Type=>"PP"
			)),
			DanaInteger(Dict{Symbol,Any}(
				:Brief=>"Number of components",
				:Default=>1
			)),
			stream(Dict{Symbol,Any}(
				:Brief=>"Inlet stream",
				:PosX=>0,
				:PosY=>0,
				:Symbol=>"_{in}"
			)),
			liquid_stream(Dict{Symbol,Any}(
				:Brief=>"Intermediary liquid outlet stream",
				:Symbol=>"_{outmL}"
			)),
			vapour_stream(Dict{Symbol,Any}(
				:Brief=>"Outlet vapour stream",
				:Symbol=>"_{outV}"
			)),
			vol_tank(Dict{Symbol,Any}(
				:Brief=>"Routine to volume tank calculation",
				:Symbol=>"_{tank}"
			)),
			fill(mol(Dict{Symbol,Any}(
				:Brief=>"Component molar holdup"
			)),(NComp)),
			mol(Dict{Symbol,Any}(
				:Brief=>"Molar liquid holdup"
			)),
			mol(Dict{Symbol,Any}(
				:Brief=>"Molar vapour holdup"
			)),
			energy(Dict{Symbol,Any}(
				:Brief=>"Internal energy"
			)),
			heat_rate(Dict{Symbol,Any}(
				:Brief=>"Reactor duty",
				:Default=>0
			)),
			volume_mol(Dict{Symbol,Any}(
				:Brief=>"Liquid Molar Volume"
			)),
			[
				:(diff(M) = Inlet.F*Inlet.z - (OutletmL.F*OutletmL.z + OutletV.F*OutletV.z)),
				:(M = ML*OutletmL.z + MV*OutletV.z),
				:(sum(OutletmL.z) = 1),
				:(sum(OutletmL.z) = sum(OutletV.z)),
				:(OutletV.v = 1),
				:(OutletmL.v = 0),
				:(diff(E) = Inlet.F*Inlet.h - (OutletmL.F*OutletmL.h + OutletV.F*OutletV.h) + Q),
				:(E = ML*OutletmL.h + MV*OutletV.h),
				:(Tank.V = ML*vL + MV*PP.VapourVolume(OutletV.T,OutletV.P,OutletV.z)),
				:(PP.LiquidFugacityCoefficient(OutletmL.T,OutletmL.P,OutletmL.z)*OutletmL.z = PP.VapourFugacityCoefficient(OutletV.T,OutletV.P,OutletV.z)*OutletV.z),
				:(OutletmL.P = OutletV.P),
				:(OutletmL.T = OutletV.T),
				:(vL = PP.LiquidVolume(OutletmL.T,OutletmL.P,OutletmL.z)),
				:(ML*vL = Tank.V),
			],
			[
				"Component molar balance","Molar holdup","Mole fraction normalisation","Mole fraction normalisation","Vapourisation fraction","Vapourisation fraction","Energy balance","Total internal energy","Geometry constraint","Chemical Equilibrium","Mechanical Equilibrium","Thermal Equilibrium","Liquid Volume","Tank Level",
			],
			[:PP,:NComp,],
			[:Inlet,:OutletmL,:OutletV,:Tank,:M,:ML,:MV,:E,:Q,:vL,]
		)
	end
	PP::DanaPlugin
	NComp::DanaInteger
	Inlet::stream
	OutletmL::liquid_stream
	OutletV::vapour_stream
	Tank::vol_tank
	M::Array{mol}
	ML::mol
	MV::mol
	E::energy
	Q::heat_rate
	vL::volume_mol
	equations::Array{Expr,1}
	equationNames::Array{String,1}
	parameters::Array{Symbol,1}
	variables::Array{Symbol,1}
	attributes::Dict{Symbol,Any}
end
export tank_liqvap
function setEquationFlow(in::tank_liqvap)
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
function atributes(in::tank_liqvap,_::Dict{Symbol,Any})
	fields::Dict{Symbol,Any}=Dict{Symbol,Any}()
	fields[:Brief]="Model of a generic two-phase tank"
	drive!(fields,_)
	return fields
end
tank_liqvap(_::Dict{Symbol,Any})=begin
	newModel=tank_liqvap()
	newModel.attributes=atributes(newModel,_)
	newModel
end
