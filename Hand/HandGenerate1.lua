shape = load("HandSubstrate.stl")

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

for k = 0,63 do

    -- Set background defaults
    for i = 0,63 do
        for j = 0,63 do
            theta:set(i,j,k, v(0,0,0))
            iso:set(i,j,k, v(1, 1, 1))
        end
    end

    -- Zone A
    for i = 0,18 do
        for j = 0,63 do
            theta:set(i,j,k, v(0.875,0.875,0.875))
            iso:set(i,j,k, v(0, 0, 0))
        end
    end

    -- Zone B
    for i = 19,42 do
        for j = 36,63 do
            theta:set(i,j,k, v(0.25,0.25,0.25))
            iso:set(i,j,k, v(0, 0, 0))
        end
    end

    -- Zone C
    for i = 19,31 do
        for j = 29,35 do
            theta:set(i,j,k, v(0.875,0.875,0.875))
            iso:set(i,j,k, v(0, 0, 0))
        end
    end

    -- Zone D
    for i = 32,59 do
        for j = 29,35 do
            theta:set(i,j,k, v(0,0,0))
            iso:set(i,j,k, v(0, 0, 0))
        end
    end

    -- Zone E
    for i = 51,63 do
        for j = 7,35 do
            if j < (7*i/9) - 10.89 then
                theta:set(i,j,k, v(0.25,0.25,0.25))
                iso:set(i,j,k, v(0, 0, 0))
            end
        end
    end

    -- Zone F
    for i = 19,33 do
        for j = 12,28 do
            if j < (-17/15)*i + 48.4 then
                theta:set(i,j,k, v(0.8125,0.8125,0.8125))
                iso:set(i,j,k, v(0, 0, 0))
            end
        end
    end

    -- Zone G
    for i = 34,59 do
        for j = 7,17 do
            if j < (-11/9)*i + 78.11 then
                if j < 6*i/17 - 0.65 then
                    theta:set(i,j,k, v(0.625,0.625,0.625))
                    iso:set(i,j,k, v(0, 0, 0))
                end
            end
        end
    end

    -- Zone H
    for i = 19,39 do
        for j = 0,11 do
            if j < (-5/6)*i + 38.5 then
                theta:set(i,j,k, v(0.25,0.25,0.25))
                iso:set(i,j,k, v(0, 0, 0))
            end
        end
    end
end



-- binding the 3D textures to the fields
-- the binding requires a field (!), a bounding box where it is applied, and the internal name of the parameter (see tooltip in UI)

set_setting_value('phasor_infill_theta_0', theta, v(0,0,0), v(80,103,5))
set_setting_value('phasor_infill_iso_0', iso, v(0,0,0), v(80,103,5))
set_setting_value('phasor_infill_phi_0', 0)
set_setting_value('infill_percentage_0', 20)
