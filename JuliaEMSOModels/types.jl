module EMLtypes
	using DanaTypes
	using DotPlusInheritance
	include("types/coefficient.jl")
	include("types/constant.jl")
	include("types/positive.jl")
	include("types/negative.jl")
	include("types/fraction.jl")
	include("types/percent.jl")
	include("types/control_signal.jl")
	include("types/efficiency.jl")
	include("types/pressure.jl")
	include("types/press_delta.jl")
	include("types/head_mass.jl")
	include("types/head.jl")
	include("types/temperature.jl")
	include("types/temp_delta.jl")
	include("types/time_h.jl")
	include("types/time_min.jl")
	include("types/time_sec.jl")
	include("types/frequency.jl")
	include("types/angle.jl")
	include("types/area.jl")
	include("types/length.jl")
	include("types/length_delta.jl")
	include("types/volume.jl")
	include("types/volume_mol.jl")
	include("types/volume_mass.jl")
	include("types/current.jl")
	include("types/charge.jl")
	include("types/capacitance.jl")
	include("types/indutance.jl")
	include("types/voltage.jl")
	include("types/resistance.jl")
	include("types/potency.jl")
	include("types/currency.jl")
	include("types/mass.jl")
	include("types/mol.jl")
	include("types/kmol.jl")
	include("types/molweight.jl")
	include("types/molweight_inv.jl")
	include("types/dens_mol.jl")
	include("types/dens_mass.jl")
	include("types/conc_mol.jl")
	include("types/inv_conc_mol.jl")
	include("types/conc_mass.jl")
	include("types/inv_conc_mass.jl")
	include("types/reaction_mol.jl")
	include("types/reaction_mass.jl")
	include("types/cp_mass.jl")
	include("types/cp_mol.jl")
	include("types/cv_mol.jl")
	include("types/enth_mass.jl")
	include("types/enth_mol.jl")
	include("types/entr_mol.jl")
	include("types/entr_mass.jl")
	include("types/heat_reaction.jl")
	include("types/heat_rate.jl")
	include("types/heat_flux.jl")
	include("types/heat_trans_coeff.jl")
	include("types/energy.jl")
	include("types/energy_mass.jl")
	include("types/energy_mol.jl")
	include("types/power.jl")
	include("types/flow_mass.jl")
	include("types/flow_mass_delta.jl")
	include("types/flow_vol.jl")
	include("types/flow_vol_delta.jl")
	include("types/flow_mol.jl")
	include("types/flow_mol_delta.jl")
	include("types/flux_mol.jl")
	include("types/flux_mol_delta.jl")
	include("types/flux_mass.jl")
	include("types/flux_mass_delta.jl")
	include("types/flux_vol.jl")
	include("types/flux_vol_delta.jl")
	include("types/vel_angular.jl")
	include("types/rotation.jl")
	include("types/velocity.jl")
	include("types/velocity_delta.jl")
	include("types/acceleration.jl")
	include("types/fricfactor.jl")
	include("types/moment_inertia.jl")
	include("types/hookes_const.jl")
	include("types/conductivity.jl")
	include("types/diffusivity.jl")
	include("types/fugacity.jl")
	include("types/viscosity.jl")
	include("types/vol_mol.jl")
	include("types/vol_mass.jl")
	include("types/spec_surface_vol.jl")
	include("types/spec_surface_mass.jl")
	include("types/surf_tens.jl")
	include("types/act_coeff.jl")
	include("types/ph.jl")
end