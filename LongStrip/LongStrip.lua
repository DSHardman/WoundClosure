shape = load("LongStrip.stl")

emit(shape)

--###########################################################

-- setting up printer settings
set_setting_value('printer', 'Prusa_MK3S')
set_setting_value('z_layer_height_mm', 0.2)

-- setting up some slicing settings
set_setting_value('infill_type_0', 'Phasor')
set_setting_value('num_shells_0', 0)
set_setting_value('cover_thickness_mm_0', 0.0)
set_setting_value('print_perimeter_0', false)
set_setting_value('infill_percentage_0',20)

-- printing settings (for TPU, on CR-10 with Titan or Hemera direct extruder)
set_setting_value('filament_priming_mm_0',0.0)
set_setting_value('extruder_temp_degree_c_0',240.0)

set_setting_value('flow_multiplier_0',1)
set_setting_value('speed_multiplier_0',1)
set_setting_value('filament_priming_mm_0',0)

--###########################################################

-- allocating  the field as 3D textures
-- as of today all fields have to be 64x64x64

iso = tex3d_rgb8f(64,64,64)
theta = tex3d_rgb8f(64,64,64)

-- filling the 3D textures
-- values in 3D textures are always in [0,1]
-- the textures can hold up to three components


for j = 0,63 do
  for k = 0,63 do
    for i = 0,7 do
        theta:set(i,j,k, v(0,0,0))
        iso:set(i,j,k, v(1, 1, 1))
    end
    for i = 8,56 do
        theta:set(i,j,k, v(0.25,0.25,0.25))
        iso:set(i,j,k, v(0, 0, 0))
    end
    for i = 57,63 do
        theta:set(i,j,k, v(0,0,0))
        iso:set(i,j,k, v(1, 1, 1))
    end
  end
end

for k = 0,63 do
  for j = 32,63 do
    for i = 8,31 do
        theta:set(i,j,k, v(0, 0, 0))
    end
  end

  for j = 32,40 do
    for i = 20,31 do
        theta:set(i,j,k, v(0.25, 0.25, 0.25))
    end
    for i = 32,43 do
        theta:set(i,j,k, v(0, 0, 0))
    end
  end
end



-- binding the 3D textures to the fields
-- the binding requires a field (!), a bounding box where it is applied, and the internal name of the parameter (see tooltip in UI)

set_setting_value('phasor_infill_theta_0', theta, v(0,0,0), v(180,35,5))
set_setting_value('phasor_infill_iso_0', iso, v(0,0,0), v(180,35,5))
set_setting_value('phasor_infill_phi_0', 0)
set_setting_value('infill_percentage_0', 20)
