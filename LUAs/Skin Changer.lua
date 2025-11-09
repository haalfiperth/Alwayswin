local InventoryChanger = { Functions = {}, Selected = {}, Skins = {}, Owned = {} };

do
    local Utilities = {};

    function cout(watermark, message)
        if not LPH_OBFUSCATED then
            return print('['..watermark..']', message);
        end;
    end;

    cout('Inventory Changer', 'Ddos niggas')

    if not getgenv().InventoryConnections then
        getgenv().InventoryConnections = {};
    end;

    local players = game:GetService('Players');
    local client = players.LocalPlayer;

    local tween_service = game:GetService('TweenService');

    Utilities.AddConnection = function(signal, func)
        local connect = signal:Connect(func);

        table.insert(getgenv().InventoryConnections, { signal = signal, func = func, connect = connect });
        return connect;
    end;

    Utilities.Unload = function()
        for _, tbl in ipairs(getgenv().InventoryConnections) do
            if type(tbl) ~= 'table' then 
                tbl:Disconnect();
            end
        end;

        getgenv().InventoryConnections = {};
    end;

    Utilities.Unload();

    Utilities.Tween = function(args)
        local obj = args.obj or args.object;
        local prop = args.prop or args.properties;
        local duration = args.duration or args.time;
        local info = args.info or args.tween_info;
        local callback = args.callback;

        local tween = tween_service:Create(obj, duration and TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) or info and TweenInfo.new(unpack(info)), prop);
        tween:Play();

        if callback then
            tween.Completed:Connect(callback);
        end;
    end;

    repeat task.wait() until client.Character:FindFirstChild('FULLY_LOADED_CHAR');

    local player_gui = client.PlayerGui;

    local main_gui = player_gui:WaitForChild('MainScreenGui');
    local crew = main_gui:WaitForChild('Crew');
    local bottom_left = crew:WaitForChild('BottomLeft').Frame;
    local skins_button = bottom_left:WaitForChild('Skins');

    local replicated_storage = game:GetService('ReplicatedStorage');
    local skin_modules = replicated_storage:WaitForChild('SkinModules');
    local meshes = skin_modules:WaitForChild('Meshes');

    local weapon_skins_gui = main_gui:WaitForChild('WeaponSkinsGUI');
    local gui_body_wrapper = weapon_skins_gui:WaitForChild('Body');
    local body_wrapper = gui_body_wrapper:WaitForChild('Wrapper');
    local skin_view = body_wrapper:WaitForChild('SkinView');
    local skin_view_frame = skin_view:WaitForChild('Frame');

    local guns = skin_view_frame:WaitForChild('Guns').Contents;
    local entries = skin_view_frame:WaitForChild('Skins').Contents.Entries;

    local Ignored = workspace.Ignored;
    local Siren = Ignored.Siren;
    local Radius = Siren.Radius;

    local regex = '%[(.-)%]';

    local newColorSequence = ColorSequence.new;
    local Color3fromRGB = Color3.fromRGB;
    local newCFrame = CFrame.new;
    local newColorSequenceKeypoint = ColorSequenceKeypoint.new;

    InventoryChanger.Skins = {
        ['Mystical'] = {
            tween_duration = 0.65,
            beam_width = 0.125,
            color = newColorSequence(Color3fromRGB(255, 39, 24)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Mystical.Revolver,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14489866118',
                    C0 = newCFrame(-0.015838623, -0.0802496076, 0.00772094727, 1, 0, 4.37113883e-08, 0, 1, 0, -4.37113883e-08, 0, 1)
                }
            }
        },
        ['CyanPack'] = {
            mesh_location = meshes.CyanPack,
            guns = {
                ['[TacticalShotgun]'] = {
                    location = meshes.CyanPack.Cloud,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14056055126',
                    C0 = newCFrame(0.0441589355, -0.0269355774, -0.000701904297, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.CyanPack.DB,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14056053588',
                    C0 = newCFrame(-0.00828552246, 0.417651355, -0.00537109375, 4.18358377e-06, -1.62920685e-07, 1, 3.4104116e-13, 1, 1.62920685e-07, -1, 3.41041052e-13, -4.18358377e-06)
                },
                ['[Revolver]'] = {
                    location = meshes.CyanPack.Devil,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14056056444',
                    C0 = newCFrame(0.0185699463, 0.293397784, -0.00256347656, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Cartoon'] = {
            guns = {
                ['[Flamethrower]'] = {
                    location = meshes.Cartoon.CartoonFT,
                    equipped = false,
                    C0 = newCFrame(-0.272186279, 0.197086751, 0.0440063477, -1, 4.8018768e-07, 8.7078952e-08, 4.80187623e-07, 1, -3.54779985e-07, -8.70791226e-08, -3.54779957e-07, -1)
                },
                ['[Revolver]'] = {
                    location = meshes.Cartoon.CartoonRev,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14221101923',
                    C0 = newCFrame(-0.015411377, 0.0135096312, 0.00338745117, 1.00000095, 3.41326549e-13, 2.84217399e-14, 3.41326549e-13, 1.00000191, -9.89490712e-10, 2.84217399e-14, -9.89490712e-10, 1.00000191)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Cartoon.DBCartoon,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14220912852',
                    C0 = newCFrame(0.00927734375, -0.00691050291, 0.000732421875, -1, -2.79396772e-08, -9.31322797e-10, -2.79396772e-08, 1, 1.42607872e-08, 9.31322575e-10, 1.42607872e-08, -1)
                },
                ['[RPG]'] = {
                    location = meshes.Cartoon.RPGCartoon,
                    equipped = false,
                    C0 = newCFrame(-0.0201721191, 0.289476752, -0.0727844238, 4.37113883e-08, 6.58276836e-37, 1, -5.72632016e-14, 1, 2.50305399e-21, -1, 5.72632016e-14, 4.37113883e-08)
                },
            }
        },
        ['Dragon'] = {
            color = newColorSequence(Color3.new(1, 0, 0)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Dragon.DragonRev,
                    equipped = false,
                    C0 = newCFrame(0.0384216309, 0.0450432301, -0.000671386719, 1.87045402e-31, 4.21188801e-16, -0.99999994, 1.77635684e-15, 1, -4.21188827e-16, 1, 1.77635684e-15, -1.87045413e-31)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Dragon.DBDragon,
                    equipped = false,
                    C0 = newCFrame(-0.123794556, 0.0481165648, 0.00048828125, 7.14693442e-07, 3.13283705e-10, 1, -4.56658222e-09, 1, -3.13281678e-10, -1, -4.56658533e-09, 7.14693442e-07)
                }
            }
        },
        ['Tact'] = {
            tween_duration = 1.25,
            beam_width = 0.125,
            color = newColorSequence(Color3.new(1, 0.3725490196, 0.3725490196)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Tact.Rev,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13850086195',
                    C0 = newCFrame(-0.318634033, -0.055095911, 0.00491333008, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Tact.DB,
                    equipped = false,
                    C0 = newCFrame(-0.0701141357, -0.0506889224, -0.0826416016, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.Tact.Tact,
                    equipped = false,
                    C0 = newCFrame(-0.0687713623, -0.0684046745, 0.12701416, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[SMG]'] = {
                    location = meshes.Tact.Uzi,
                    equipped = false,
                    C0 = newCFrame(0.0408782959, 0.0827783346, -0.0423583984, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[Shotgun]'] = {
                    location = meshes.Tact.Shotgun,
                    equipped = false,
                    C0 = newCFrame(-0.0610046387, 0.171100497, -0.00495910645, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Silencer]'] = {
                    location = meshes.Tact.Silencer,
                    equipped = false,
                    C0 = newCFrame(0.0766601562, -0.0350288749, -0.648864746, 1, 0, -4.37113883e-08, 0, 1, 0, 4.37113883e-08, 0, 1)
                }
            }
        },
        ['Shadow'] = {
            color = newColorSequence(Color3.new(0.560784, 0.470588, 1), Color3.new(0.576471, 0.380392, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Shadow.RevolverGhost,
                    equipped = false,
                    C0 = newCFrame(-0.18438721, 0.28277695, 0.00103760, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Shadow.DoubleBGhost,
                    equipped = false,
                    C0 = newCFrame(0.43927765, 0.28647220, -0.12356567, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[AK47]'] = {
                    location = meshes.Shadow.AK47Ghost,
                    equipped = false,
                    C0 = newCFrame(0.57516479, 0.31069893, 0.00003052, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[SilencerAR]'] = {
                    location = meshes.Shadow.ARGhost,
                    equipped = false,
                    C0 = newCFrame(-2.44378662, 0.33813697, -0.00073242, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[AUG]'] = {
                    location = meshes.Shadow.AUGGhost,
                    equipped = false,
                    C0 = newCFrame(-0.03610229, 0.59540403, -0.03814697, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[DrumGun]'] = {
                    location = meshes.Shadow.DrumgunGhost,
                    equipped = false,
                    C0 = newCFrame(0.38986206, -0.06597131, -0.00396729, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[Flamethrower]'] = {
                    location = meshes.Shadow.FlamethrowerGhost,
                    equipped = false,
                    C0 = newCFrame(-0.45349121, -0.28500497, -0.01654053, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[Glock]'] = {
                    location = meshes.Shadow.GlockGhost,
                    equipped = false,
                    C0 = newCFrame(-0.00045776, 0.45597738, -0.31884766, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[LMG]'] = {
                    location = meshes.Shadow.LMGGhost,
                    equipped = false,
                    C0 = newCFrame(0.80480957, 0.37869263, 0.00717163, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[P90]'] = {
                    location = meshes.Shadow.P90Ghost,
                    equipped = false,
                    C0 = newCFrame(-0.00479126, 0.11370850, 0.00003052, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[RPG]'] = {
                    location = meshes.Shadow.RPGGhost,
                    equipped = false,
                    C0 = newCFrame(-0.00476074, 0.26004291, -0.00039673, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[Rifle]'] = {
                    location = meshes.Shadow.RifleGhost,
                    equipped = false,
                    C0 = newCFrame(0.23178101, 0.47061515, -0.01272583, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[SMG]'] = {
                    location = meshes.Shadow.SMGGhost,
                    equipped = false,
                    C0 = newCFrame(0.04119873, 0.08865333, -0.00384521, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[Shotgun]'] = {
                    location = meshes.Shadow.ShotgunGhost,
                    equipped = false,
                    C0 = newCFrame(0.08795166, 0.52835083, -0.00518799, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.Shadow.TacticalShotgunGhost,
                    equipped = false,
                    C0 = newCFrame(0.08599854, 0.32586670, 0.00003052, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000, 0.00000000, 0.00000000, 0.00000000, 1.00000000)
                }
            }
        },
        ['Golden Age'] = {
            tween_duration = 1.25,
            beam_width = 0.125,
            color = newColorSequence(Color3.fromHSV(0.89166666666, 0.24, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.GoldenAge.Revolver,
                    equipped = false,
                    C0 = newCFrame(0.0295257568, 0.0725820661, -0.000946044922, 1, -4.89858741e-16, -7.98081238e-23, 4.89858741e-16, 1, 3.2584137e-07, -7.98081238e-23, -3.2584137e-07, 1),
                    shoot_sound = 'rbxassetid://1898322396'
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.GoldenAge['Double Barrel'],
                    equipped = false,
                    shoot_sound = 'rbxassetid://4915503055',
                    C0 = newCFrame(-0.00664520264, 0.0538104773, 0.0124816895, -1, 4.89858741e-16, 7.98081238e-23, 4.89858741e-16, 1, 3.2584137e-07, 7.98081238e-23, 3.2584137e-07, -1)
                }
            }
        },
        ['Red Skull'] = {
            color = newColorSequence(Color3.new(0.917647, 0, 0)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.RedSkull.RedSkullRev,
                    equipped = false,
                    C0 = newCFrame(-0.0043258667, 0.0084195137, -0.00238037109, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Shotgun]'] = {
                    location = meshes.RedSkull.RedSkullRev,
                    equipped = false,
                    C0 = newCFrame(-0.00326538086, 0.0239292979, -0.039352417, -4.37113883e-08, 0, -1, 0, 1, 0, 1, 0, -4.37113883e-08)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.RedSkull.RedSkullRev,
                    equipped = false,
                    C0 = newCFrame(-0.0143432617, -0.151709318, 0.00820922852, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[RPG]'] = {
                    location = meshes.RedSkull.RedSkullRev,
                    equipped = false,
                    C0 = newCFrame(-0.00149536133, 0.254377961, 0.804840088, -1, 0, 4.37113883e-08, -2.50305399e-21, 1, -5.72632016e-14, -4.37113883e-08, 5.72632016e-14, -1)
                }
            }
        },
        ['Galaxy'] = {
            border_color = newColorSequence(Color3.new(0, 0, 1)),
            particle = {
                properties = {
                    Color = ColorSequence.new({
                        newColorSequenceKeypoint(0, Color3.new(0.419608, 0.376471, 1)),
                        newColorSequenceKeypoint(1, Color3.new(0.419608, 0.376471, 1))
                    }),
                    Name = 'Galaxy',
                    Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.5),
                        NumberSequenceKeypoint.new(0.496, 1.2),
                        NumberSequenceKeypoint.new(1, 0.5)
                    }),
                    Squash = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.173364, 0.525),
                        NumberSequenceKeypoint.new(0.584386, -1.7625),
                        NumberSequenceKeypoint.new(0.98163, 0.0749998),
                        NumberSequenceKeypoint.new(1, 0)
                    }),
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.107922, 1),
                        NumberSequenceKeypoint.new(0.391504, 0.25),
                        NumberSequenceKeypoint.new(0.670494, 0.78125),
                        NumberSequenceKeypoint.new(0.845006, 0),
                        NumberSequenceKeypoint.new(1, 1)
                    }),
                    Texture = 'rbxassetid://7422600824',
                    ZOffset = 1,
                    LightEmission = 0.7,
                    Lifetime = NumberRange.new(1, 1),
                    Rate = 3,
                    Rotation = NumberRange.new(0, 360),
                    RotSpeed = NumberRange.new(0, 15),
                    Speed = NumberRange.new(1, 1),
                    SpreadAngle = Vector2.new(-45, 45)
                }
            },
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    texture = 'rbxassetid://9370936730'
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    texture = 'rbxassetid://9402279010'
                }
            }
        },
        ['Kitty'] = {
            tween_duration = 1,
            beam_width = 0.125,
            color = newColorSequence(Color3.new(1, 0.690196, 0.882353), Color3.new(1, 0.929412, 0.964706)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Kitty.KittyRevolver,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13483022860',
                    C0 = newCFrame(0.0310440063, 0.0737591386, 0.0226745605, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    location = meshes.Kitty.KittyFT,
                    equipped = false,
                    C0 = newCFrame(-0.265670776, 0.115545571, 0.00997924805, -1, 9.74078034e-21, 5.47124086e-13, 9.74092898e-21, 1, 3.12638804e-13, -5.47126309e-13, 3.12638804e-13, -1)
                },
                ['[RPG]'] = {
                    location = meshes.Kitty.KittyRPG,
                    equipped = false,
                    C0 = newCFrame(0.0268554688, 0.0252066851, 0.117408752, -1, 2.51111284e-40, 4.37113883e-08, -3.7545812e-20, 1, -8.58948004e-13, -4.37113883e-08, 8.58948004e-13, -1)
                },
                ['[Shotgun]'] = {
                    location = meshes.Kitty.KittyShotgun,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13483035672',
                    C0 = newCFrame(0.0233459473, 0.223892093, -0.0213623047, 4.37118963e-08, -6.53699317e-13, 1, 3.47284736e-20, 1, 7.38964445e-13, -0.999997139, 8.69506734e-21, 4.37119354e-08)
                }
            }
        },
        ['Toy'] = {
            mesh_location = meshes.Toy,
            tween_duration = 1.25,
            color = newColorSequence({newColorSequenceKeypoint(0, Color3.new(0, 1, 0)), ColorSequenceKeypoint.new(0.5, Color3.new(0.666667, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.666667, 0))}),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Toy.RevolverTOY,
                    equipped = false,
                    C0 = newCFrame(-0.0250854492, -0.144362092, -0.00266647339, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[LMG]'] = {
                    location = meshes.Toy.LMGTOY,
                    equipped = false,
                    C0 = newCFrame(-0.285247803, -0.0942560434, -0.270412445, 1, 0, 4.37113883e-08, 0, 1, 0, -4.37113883e-08, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Toy.DBToy,
                    equipped = false,
                    C0 = newCFrame(-0.0484313965, -0.00164616108, -0.0190467834, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[RPG]'] = {
                    location = meshes.Toy.RPGToy,
                    equipped = false,
                    C0 = newCFrame(0.00121307373, 0.261434197, -0.318969727, 1, 2.5768439e-12, -4.37113883e-08, 2.57684412e-12, 1, 6.29895225e-12, 4.37113883e-08, 6.29895225e-12, 1)
                }
            }
        },
        ['Galactic'] = {
            mesh_location = meshes.Galactic,
            tween_duration = 1.25,
            color = newColorSequence(Color3.new(1, 0, 0)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Galactic.galacticRev,
                    equipped = false,
                    C0 = newCFrame(-0.049041748, 0.0399398208, -0.00772094727, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.Galactic.TacticalGalactic,
                    equipped = false,
                    C0 = newCFrame(-0.0411682129, -0.0281000137, 0.00103759766, 0, 5.68434189e-14, 1, -1.91456822e-13, 1, 5.68434189e-14, -1, 1.91456822e-13, 0)
                }
            }
        },
        ['Water'] = {
            tween_duration = 1.25,
            tween_type = 'Both',
            beam_width = 0.125,
            color = newColorSequence(Color3.new(0, 1, 1), Color3.new(0.666667, 1, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Water.WaterGunRevolver,
                    equipped = false,
                    C0 = newCFrame(-0.0440063477, 0.028675437, -0.00469970703, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.Water.TactWater,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13814991449',
                    C0 = newCFrame(0.0238037109, -0.00912904739, 0.00485229492, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Water.DBWater,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13814990235',
                    C0 = newCFrame(-0.0710754395, 0.00169920921, -0.0888671875, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[Flamethrower]'] = {
                    location = meshes.Water.FTWater,
                    equipped = false,
                    C0 = newCFrame(0.0941314697, 0.593509138, 0.0191040039, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                }
            }
        },
        ['GPO'] = {
            color = newColorSequence(Color3.new(1, 0.666667, 0)),
            guns = {
                ['[RPG]'] = {
                    location = meshes.GPO.Bazooka,
                    equipped = false,
                    C0 = newCFrame(-0.0184631348, 0.0707798004, 0.219360352, 4.37113883e-08, 1.07062025e-23, 1, -5.75081297e-14, 1, 1.14251725e-36, -1, 5.70182736e-14, 4.37113883e-08)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.GPO.MaguTact,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13998711419',
                    C0 = newCFrame(-0.282501221, 0.0472121239, -0.0065612793, -6.60624482e-06, 1.5649757e-08, -1, -5.68434189e-14, 1, -1.56486806e-08, 1, 5.68434189e-14, -6.60624482e-06)
                },
                ['[Rifle]'] = {
                    location = meshes.GPO.Rifle,
                    equipped = false,
                    C0 = newCFrame(-0.208007812, 0.185256913, 0.000610351562, -3.37081539e-14, 1.62803403e-07, -1.00000012, -8.74227695e-08, 0.999999881, 1.63036205e-07, 1, 8.74227766e-08, -1.94552524e-14)
                }
            }
        },
        ['BIT8'] = {
            tween_duration = 1.25,
            tween_type = 'Width',
            beam_width = 0.125,
            color = newColorSequence(Color3.fromHSV(0.5, 0.9, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.BIT8.RPixel,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13326584088',
                    C0 = newCFrame(0.0261230469, -0.042888701, 0.00260925293, -1, 1.355249e-20, -3.55271071e-15, 1.355249e-20, 1, -1.81903294e-27, 3.55271071e-15, -1.81903294e-27, -1)
                },
                ['[Flamethrower]'] = {
                    location = meshes.BIT8.FTPixel,
                    equipped = false,
                    C0 = newCFrame(-0.0906066895, -0.0161985159, -0.0117645264, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.BIT8.DBPixel,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13326578563',
                    C0 = newCFrame(-0.240386963, -0.127295256, -0.00776672363, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[RPG]'] = {
                    location = meshes.BIT8.RPGPixel,
                    equipped = false,
                    C0 = newCFrame(0.0102081299, 0.0659624338, 0.362945557, 4.37113883e-08, 0, 1, -5.72632016e-14, 1, 2.50305399e-21, -1, 5.72632016e-14, 4.37113883e-08)
                }
            }
        },
        ['Electric'] = {
            color = newColorSequence(Color3.new(0, 1, 1), Color3.new(0.666667, 1, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Electric.ElectricRevolver,
                    equipped = false,
                    C0 = newCFrame(0.185462952, 0.0312761068, 0.000610351562, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[DrumGun]'] = {
                    location = meshes.Electric.ElectricDrum,
                    equipped = false,
                    C0 = newCFrame(-0.471969604, 0.184426308, 0.075378418, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[SMG]'] = {
                    location = meshes.Electric.ElectricSMG,
                    equipped = false,
                    C0 = newCFrame(-0.0620956421, 0.109580457, 0.00729370117, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    location = meshes.Electric.ElectricShotgun,
                    equipped = false,
                    C0 = newCFrame(6.10351562e-05, 0.180232108, -0.624732971, 1, 0, -4.37113883e-08, 0, 1, 0, 4.37113883e-08, 0, 1)
                },
                ['[Rifle]'] = {
                    location = meshes.Electric.ElectricRifle,
                    equipped = false,
                    C0 = newCFrame(0.181793213, -0.0415201783, 0.00421142578, 1.8189894e-12, 6.6174449e-24, 1, 7.27595761e-12, 1, 6.6174449e-24, -1, -7.27595761e-12, -1.8189894e-12)
                },
                ['[P90]'] = {
                    location = meshes.Electric.ElectricP90,
                    equipped = false,
                    C0 = newCFrame(0.166191101, -0.225557804, -0.0075378418, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[LMG]'] = {
                    location = meshes.Electric.ElectricLMG,
                    equipped = false,
                    C0 = newCFrame(0.142379761, 0.104723871, -0.303771973, -1, 0, -4.37113883e-08, 0, 1, 0, 4.37113883e-08, 0, -1)
                },
                ['[Flamethrower]'] = {
                    location = meshes.Electric.ElectricFT,
                    equipped = false,
                    C0 = newCFrame(-0.158782959, 0.173444271, 0.00640869141, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Electric.ElectricDB,
                    equipped = false,
                    C0 = newCFrame(0.0755996704, -0.0420352221, 0.00543212891, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Glock]'] = {
                    location = meshes.Electric.ElectricGlock,
                    equipped = false,
                    C0 = newCFrame(-0.00207519531, 0.0318723917, 0.0401077271, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[AUG]'] = {
                    location = meshes.Electric.ElectricAUG,
                    equipped = false,
                    C0 = newCFrame(0.331085205, -0.0117390156, 0.00155639648, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[SilencerAR]'] = {
                    location = meshes.Electric.ElectricAR,
                    equipped = false,
                    C0 = newCFrame(-0.16942215, 0.0508521795, 0.0669250488, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[AK47]'] = {
                    location = meshes.Electric.ElectricAK,
                    equipped = false,
                    C0 = newCFrame(-0.750015259, 4.76837158e-07, -3.05175781e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Halloween23'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Halloween.Rev,
                    shoot_sound = 'rbxassetid://14924285721',
                    C0 = newCFrame(-0.0257873535, -0.0117108226, -0.00671386719, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Halloween.DB,
                    shoot_sound = 'rbxassetid://14924282919',
                    C0 = newCFrame(-0.00271606445, -0.0485508144, 0.000732421875, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    equipped = false,
                    location = meshes.Halloween.SG,
                    shoot_sound = 'rbxassetid://14924268000',
                    C0 = newCFrame(0.00573730469, 0.294590235, -0.115814209, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Halloween.Tact,
                    shoot_sound = 'rbxassetid://14924256223',
                    C0 = newCFrame(-0.0715637207, -0.0843618512, 0.00582885742, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                }
            }
        },
        ['Soul'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Soul.rev,
                    shoot_sound = 'rbxassetid://14909152822',
                    C0 = newCFrame(-0.0646362305, 0.2725088, -0.00242614746, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Soul.db,
                    shoot_sound = 'rbxassetid://14909164664',
                    C0 = newCFrame(0.405822754, 0.0975035429, -0.00506591797, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Soul.tact,
                    shoot_sound = 'rbxassetid://14918188609',
                    C0 = newCFrame(-0.347473145, 0.0268714428, 0.00553894043, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Heaven'] = {
            color = newColorSequence(Color3.new(1, 1, 1)),
            tween_duration = 1.25,
            easing_style = Enum.EasingStyle.Quad,
            easing_direction = Enum.EasingDirection.Out,
            beam_width = 0.13,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Heaven.Revolver,
                    C0 = newCFrame(-0.0829315186, -0.0831851959, -0.00296020508, -0.999999881, 2.94089277e-17, 8.27179774e-25, -2.94089277e-17, 0.999999881, 6.85215614e-16, 8.27179922e-25, -6.85215667e-16, -1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Heaven.DB,
                    shoot_sound = 'rbxassetid://14489852879',
                    C0 = newCFrame(-0.0303955078, 0.022110641, 0.00296020508, -0.999997139, -7.05812226e-16, 7.85568618e-30, 7.05812226e-16, 0.999997139, -2.06501178e-14, 6.44518474e-30, 2.06501042e-14, -0.999999046)
                }
            }
        },
        ['Void'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Void.rev,
                    C0 = newCFrame(-0.00503540039, 0.0082899332, -0.00164794922, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Void.tact,
                    C0 = newCFrame(0.0505371094, -0.0487936139, 0.00158691406, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                }
            }
        },
        ['DH-Stars II'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Popular.STARSREV,
                    C0 = newCFrame(0.0578613281, -0.0479719043, -0.00115966797, -1.00000405, 1.15596135e-16, 1.64267286e-30, -1.15596135e-16, 1, 2.99751983e-14, 1.66683049e-30, -2.99751983e-14, -1.00000405)
                }
            }
        },
        ['DH-Verified'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Popular.VERIFIEDREV,
                    C0 = newCFrame(0.049407959, -0.0454721451, 0.00158691406, -1, 0, 0, 0, 1, 2.22044605e-15, 0, -2.22044605e-15, -1)
                }
            }
        },
        ['Candy'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Candy.RevolverCandy,
                    C0 = newCFrame(-0.106658936, -0.0681198835, 0.00198364258, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Candy.DBCandy,
                    C0 = newCFrame(0.0430603027, -0.0375298262, -0.00198364258, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                }
            }
        },
        ['Electric'] = {
            tween_duration = 1,
            beam_width = 0.125,
            color = newColorSequence(Color3fromRGB(0, 255, 255)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricRevolver,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[DrumGun]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricDrum,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricFT,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricDB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricRPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[SMG]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricSMG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricShotgun,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[P90]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricP90,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[LMG]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricLMG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Glock]'] = {
                    equipped = false,
                    location = meshes.Electric.ElectricGlock,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Water'] = {
            tween_duration = 1,
            beam_width = 0.125,
            color = newColorSequence(Color3fromRGB(52, 152, 219)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Water.WaterGunRevolver,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Water.DBWater,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Water.TactWater,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Water.FTWater,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['BIT8'] = {
            tween_duration = 0.8,
            beam_width = 0.15,
            color = newColorSequence(Color3fromRGB(255, 0, 255), Color3fromRGB(0, 255, 255)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.BIT8.RPixel,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.BIT8.RPGPixel,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.BIT8.FTPixel,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.BIT8.DBPixel,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Toy'] = {
            color = newColorSequence(Color3fromRGB(255, 100, 100)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Toy.RevolverTOY,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[LMG]'] = {
                    equipped = false,
                    location = meshes.Toy.LMGTOY,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Toy.DBToy,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Toy.RPGToy,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Galactic'] = {
            color = newColorSequence(Color3fromRGB(138, 43, 226), Color3fromRGB(75, 0, 130)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Galactic.galacticRev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Galactic.TacticalGalactic,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Stars'] = {
            tween_duration = 1.1,
            beam_width = 0.125,
            color = newColorSequence(Color3fromRGB(255, 215, 0), Color3fromRGB(255, 255, 150)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Stars.Revolver,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Stars.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Stars.RPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Stars.Flamethrower,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Barbie'] = {
            tween_duration = 1,
            beam_width = 0.125,
            color = newColorSequence(Color3fromRGB(255, 105, 180), Color3fromRGB(255, 192, 203)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Barbie.Revol,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Barbie.db,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Barbie.rpg,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Ice'] = {
            tween_duration = 1.2,
            beam_width = 0.13,
            color = newColorSequence(Color3fromRGB(173, 216, 230), Color3fromRGB(135, 206, 250)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Ice.rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Ice.tact,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Ice.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Ice.RPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Raygun'] = {
            tween_duration = 0.9,
            beam_width = 0.15,
            color = newColorSequence(Color3fromRGB(0, 255, 0), Color3fromRGB(124, 252, 0)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Raygun.rev,
                    shoot_sound = 'rbxassetid://130113322',
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Silencer]'] = {
                    equipped = false,
                    location = meshes.Raygun.mummy,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['GPOII'] = {
            color = newColorSequence(Color3fromRGB(255, 200, 0)),
            guns = {
                ['[SMG]'] = {
                    equipped = false,
                    location = meshes.GPOII.Uzi,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[AK47]'] = {
                    equipped = false,
                    location = meshes.GPOII.AK,
                    C0 = newCFrame(-0.750015259, 4.76837158e-07, -3.05175781e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[AUG]'] = {
                    equipped = false,
                    location = meshes.GPOII.AUG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.GPOII.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.GPOII.RPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Undead'] = {
            color = newColorSequence(Color3fromRGB(85, 170, 0)),
            tween_duration = 1,
            guns = {
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Undead.Tact,
                    C0 = newCFrame(0.507415771, 0.0815758705, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Undead.RPG,
                    C0 = newCFrame(-2.67796803, -0.100869253, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Undead.rev,
                    C0 = newCFrame(0.233276367, 0.252155304, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Undead.AstroDB,
                    C0 = newCFrame(-0.821960449, -0.0625269413, 0.0234069824, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Spooky'] = {
            color = newColorSequence(Color3fromRGB(255, 127, 0)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Spooky.rev,
                    C0 = newCFrame(0.00224228832, 0.0645515621, -0.126843929, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Spooky.tact,
                    C0 = newCFrame(-0.500854492, 0.184952736, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Spooky.FT,
                    C0 = newCFrame(-0.00231933594, 0.120510817, -0.402618408, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Spooky.DB,
                    C0 = newCFrame(0.0775646642, 0.130365416, 0.00194451807, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Hoodmas'] = {
            color = newColorSequence(Color3fromRGB(255, 0, 0)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Hoodmas.revolver,
                    C0 = newCFrame(0.622470856, 0.354640961, -0.154830933, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Hoodmas.db,
                    C0 = newCFrame(-0.375823975, 0.340094447, -0.22428894, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    equipped = false,
                    location = meshes.Hoodmas.shotgun,
                    C0 = newCFrame(-0.807174683, 0.524583817, -0.0795898438, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Hoodmas.tact,
                    C0 = newCFrame(0.0402889252, 0.515531063, -0.14503479, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Hoodmas.flamethrower,
                    C0 = newCFrame(0.520633698, 0.15495038, 0.364944458, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Hoodmas.rpg,
                    C0 = newCFrame(2.21431541, 0.339945316, -0.173141479, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['XMAS'] = {
            color = newColorSequence(Color3fromRGB(255, 255, 255)),
            tween_duration = 1,
            guns = {
                ['[Shotgun]'] = {
                    equipped = false,
                    location = meshes.XMAS.Sg,
                    C0 = newCFrame(-2.02876282, 0.470371902, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Ruby'] = {
            color = newColorSequence(Color3fromRGB(220, 20, 60)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Ruby.rev,
                    C0 = newCFrame(0.0123981657, 0.196298853, -0.304277092, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Ruby.db,
                    C0 = newCFrame(0.00562712038, 0.132610828, -0.021578379, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Ruby.ft,
                    C0 = newCFrame(0.225437641, -0.184734493, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Ruby.RPG,
                    C0 = newCFrame(0, 0.0248689651, -0.0191955566, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Penguin'] = {
            color = newColorSequence(Color3fromRGB(0, 191, 255)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Penguin.rev,
                    C0 = newCFrame(0.0233154297, 0.200686157, 0.115356445, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Penguin.db,
                    C0 = newCFrame(0.023980245, 0.211847126, 0.178914338, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Penguin.rpg,
                    C0 = newCFrame(0.0759887695, 0.27518636, 0.0133666992, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07)
                }
            }
        },
        ['Metal'] = {
            color = newColorSequence(Color3fromRGB(192, 192, 192)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Metal.rev,
                    C0 = newCFrame(0.021446228, -0.20308125, 0.000366210938, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Rifle]'] = {
                    equipped = false,
                    location = meshes.Metal.rifle,
                    C0 = newCFrame(-0.000366210938, 0.0314085484, 0.251075745, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Metal.rpg,
                    C0 = newCFrame(0, 0.233782768, -2.70129395, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Metal.db,
                    C0 = newCFrame(0, 0.0958871841, 0.00590515137, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Metal.ft,
                    C0 = newCFrame(0.00158691406, -0.239719391, -0.190101624, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Unicorn'] = {
            color = newColorSequence(Color3fromRGB(255, 105, 180)),
            tween_duration = 1,
            guns = {
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Unicorn.rpg,
                    C0 = newCFrame(0.270519257, -0.358043492, 0.0443115234, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Unicorn.rev,
                    C0 = newCFrame(0.0593719482, -0.218066692, -0.0104370117, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Unicorn.tact,
                    C0 = newCFrame(0.536289215, -0.202373743, -0.0278320312, 0.99985975, 0, 0.016745884, 0, 1, 0, -0.016745884, 0, 0.99985975)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Unicorn.db,
                    C0 = newCFrame(0.345825195, -0.229066372, 0.0103149414, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Cat'] = {
            color = newColorSequence(Color3fromRGB(255, 192, 203)),
            tween_duration = 1,
            guns = {
                ['[DrumGun]'] = {
                    equipped = false,
                    location = meshes.Cat.drum,
                    C0 = newCFrame(5.34057617e-05, 0.000196456909, 0.000183105469, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Cat.db,
                    C0 = newCFrame(-6.10351562e-05, -0.000276744366, -6.10351562e-05, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Cat.rpg,
                    C0 = newCFrame(0.562919617, 0.0103535652, -0.0208129883, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Cat.Rev,
                    C0 = newCFrame(-0.000232696533, 0.000271260738, -0.000122070312, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                }
            }
        },
        ['Arcade'] = {
            color = newColorSequence(Color3fromRGB(255, 0, 255)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Arcade.Rev,
                    C0 = newCFrame(0.200000003, 0.200000003, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Arcade.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Nightmare'] = {
            color = newColorSequence(Color3fromRGB(138, 43, 226)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Nightmare.rev,
                    C0 = newCFrame(0.00354003906, 0.340431601, -0.0355377197, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Nightmare.db,
                    C0 = newCFrame(-0.435666859, 0.345736802, 0, -0.965929747, -0.258804798, 0, -0.258804798, 0.965929627, 0, -0, 0, -1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Nightmare.rpg,
                    C0 = newCFrame(-1.97019494, 0.385884702, -0.221447527, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Nightmare.ft,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Emerald'] = {
            color = newColorSequence(Color3fromRGB(0, 201, 87)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Emerald.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Emerald.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[AK47]'] = {
                    equipped = false,
                    location = meshes.Emerald.AK,
                    C0 = newCFrame(-0.750015259, 4.76837158e-07, -3.05175781e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Skull'] = {
            color = newColorSequence(Color3fromRGB(255, 255, 255)),
            tween_duration = 1,
            guns = {
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Skull.rpg,
                    C0 = newCFrame(-0.495920181, 0.044311285, 0.169952393, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Skull.rev,
                    C0 = newCFrame(-0.0698056668, -0.0321852975, 0.121695913, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Blaze'] = {
            color = newColorSequence(Color3fromRGB(255, 69, 0)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Blaze.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Duck'] = {
            color = newColorSequence(Color3fromRGB(255, 215, 0)),
            tween_duration = 1,
            guns = {
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Duck.RPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Duck.DB,
                    C0 = newCFrame(1.35247803, 0.201942444, 0.009765625, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Duck.Flamethrower,
                    C0 = newCFrame(1.97369385, -0.0992202759, -0.0256347656, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Duck.Rev,
                    C0 = newCFrame(0.885437012, 0.161000252, 0.00280761719, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Blossom'] = {
            color = newColorSequence(Color3fromRGB(255, 182, 193)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Blossom.rev,
                    C0 = newCFrame(0.243389517, 0.331892997, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Blossom.db,
                    C0 = newCFrame(-0.557214797, 0.355935097, 0.0205309205, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                }
            }
        },
        ['Samurai'] = {
            color = newColorSequence(Color3fromRGB(178, 34, 34)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Samurai.Rev,
                    C0 = newCFrame(-3.05175781e-05, 0.333099604, -0.205047607, 0, 0, -1, -1, 0, 0, 0, 1, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Samurai.DB,
                    C0 = newCFrame(0, 0.28677085, -0.416687012, 0, 0, -1, -1, 0, 0, 0, 1, 0)
                }
            }
        },
        ['Jellyfish'] = {
            color = newColorSequence(Color3fromRGB(72, 209, 204)),
            tween_duration = 1,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Jellyfish.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Jellyfish.RPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Jellyfish.Tact,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Jellyfish.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Summer'] = {
            color = newColorSequence(Color3fromRGB(135, 206, 250)),
            tween_duration = 1,
            guns = {
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Summer.Tac,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Summer.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['HERO'] = {
            color = newColorSequence(Color3fromRGB(255, 215, 0)),
            tween_duration = 1,
            guns = {
                ['[Bat]'] = {
                    equipped = false,
                    location = meshes.HERO.HeroBat,
                    C0 = newCFrame(0.000274658203, 0.406370699, -2.00204468, -1, 0, 0, 0, 1, 0, 0, 0, -1),
                    shoot_sound = "rbxassetid://12345678"
                }
            }
        },

        ['RedSkull'] = {
            color = newColorSequence(Color3fromRGB(220, 20, 60)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.RedSkull.RedSkullRev,
                    C0 = newCFrame(0, 0.290665448, -0.352600098, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.RedSkull.RedSkullDB,
                    C0 = newCFrame(0.640419006, 0.317052007, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.RedSkull.RedSkullRPG,
                    C0 = newCFrame(0, 0.00158643723, -0.0691299438, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    equipped = false,
                    location = meshes.RedSkull.RedSkullShotgun,
                    C0 = newCFrame(-0.485122681, 0.210753143, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['GoldenAge'] = {
            color = newColorSequence(Color3fromRGB(255, 215, 0)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.GoldenAge.Revolver,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.GoldenAge["Double Barrel"],
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Kitty'] = {
            color = newColorSequence(Color3fromRGB(255, 182, 193)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Kitty.KittyRevolver,
                    C0 = newCFrame(0.228302002, 0.271817625, -0.0126342773, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Kitty.KittyFT,
                    C0 = newCFrame(0.0226898193, 0.312031984, -0.00387573242, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Kitty.KittyRPG,
                    C0 = newCFrame(0.0209655762, 0.394407988, 0.0327453613, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Shotgun]'] = {
                    equipped = false,
                    location = meshes.Kitty.KittyShotgun,
                    C0 = newCFrame(0.0346450806, 0.116171777, 0.121246338, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Void'] = {
            color = newColorSequence(Color3fromRGB(75, 0, 130)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Void.rev,
                    C0 = newCFrame(0.00524543645, 0.364320785, -0.210745484, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Void.tact,
                    C0 = newCFrame(0.0371063463, -0.0142971212, -0.133521169, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Soul'] = {
            color = newColorSequence(Color3fromRGB(147, 112, 219)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Soul.rev,
                    C0 = newCFrame(0, -0.180829048, -0.049987793, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Soul.db,
                    C0 = newCFrame(-0.307525635, 0.470537841, -0.00357055664, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Soul.tact,
                    C0 = newCFrame(0.726013184, 0.324090004, -0.00146484375, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Halloween'] = {
            color = newColorSequence(Color3fromRGB(255, 140, 0)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Halloween.Rev,
                    C0 = newCFrame(0.282348633, 0.296248972, 0.000701904297, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                }
            }
        },

        ['Ninja'] = {
            color = newColorSequence(Color3fromRGB(30, 30, 30)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Ninja.NinjaRev,
                    C0 = newCFrame(0.00277266256, 0.215494365, -0.442031741, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Ninja.NinjaDB,
                    C0 = newCFrame(-0.011953054, 0.24272503, -1.17124701, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                }
            }
        },

        ['Love'] = {
            color = newColorSequence(Color3fromRGB(255, 20, 147)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Love.rev,
                    C0 = newCFrame(-0.0848870873, 0.261785954, -0.00279061729, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Love.Tact,
                    C0 = newCFrame(0.000441735523, 0.060757041, 0.074690111, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Love.DB,
                    C0 = newCFrame(-0.230723709, 0.242281601, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Cupid'] = {
            color = newColorSequence(Color3fromRGB(255, 105, 180)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Cupid.rev,
                    C0 = newCFrame(-0.068359375, -0.0401213765, 0.0853881836, -2.40802765e-05, 6.40749931e-07, 1, 0.0532070547, 0.998583496, 6.40749931e-07, -0.998583555, 0.0532070547, -2.40802765e-05)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Cupid.db,
                    C0 = newCFrame(0.0171508789, 0.178858757, -0.196731567, -2.40802765e-05, 6.40749931e-07, 1, 0.0532070547, 0.998583496, 6.40749931e-07, -0.998583555, 0.0532070547, -2.40802765e-05)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Cupid.rpg,
                    C0 = newCFrame(-2.19641113, 0, 0.103263497, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Shader'] = {
            color = newColorSequence(Color3fromRGB(138, 43, 226)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Shader.Rev,
                    C0 = newCFrame(0.147354126, -0.0123209953, -0.001953125, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Shader.DB,
                    C0 = newCFrame(-0.00364208827, -0.263738722, -0.763288736, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Etheral'] = {
            color = newColorSequence(Color3fromRGB(0, 255, 127)),
            guns = {
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Etheral.RPG,
                    C0 = newCFrame(0.095080778, 0.0844801888, 0.0146337682, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Etheral.Rev,
                    C0 = newCFrame(-0.0274802689, 0.383837253, -0.00035948024, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Reptile'] = {
            color = newColorSequence(Color3fromRGB(50, 205, 50)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Reptile.rev,
                    C0 = newCFrame(-0.0190582275, 0.309286773, -0.00805664062, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Reptile.db,
                    C0 = newCFrame(-0.395362854, 0.162201971, -0.00286865234, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Aqua'] = {
            color = newColorSequence(Color3fromRGB(0, 191, 255)),
            guns = {
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Aqua.db,
                    C0 = newCFrame(0, 0.0933356807, 0.0133289061, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Aqua.rpg,
                    C0 = newCFrame(0, 0.0676318854, -0.545586944, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Numbers'] = {
            color = newColorSequence(Color3fromRGB(255, 215, 0)),
            guns = {
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Numbers.Tactical,
                    C0 = newCFrame(-0.0109863281, 0.261700094, -0.043548584, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Numbers.MagmaDB,
                    C0 = newCFrame(-9.15527344e-05, -0.363180637, 1.39297485, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Candy'] = {
            color = newColorSequence(Color3fromRGB(255, 105, 180)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Candy.RevolverCandy,
                    C0 = newCFrame(0, 0.650983334, 0.149658203, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[LMG]'] = {
                    equipped = false,
                    location = meshes.Candy.LMG,
                    C0 = newCFrame(0.224700928, 0.553636432, -0.0839233398, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Candy.DBCandy,
                    C0 = newCFrame(0.000335693359, 0.0129173994, 1.16637421, -1.00000024, 0, 0, 0, 0.534893215, -0.844919741, -0, -0.844919741, -0.534893394)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Candy.RPG,
                    C0 = newCFrame(-3.05175781e-05, 0.410267711, -0.104766846, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Wire'] = {
            color = newColorSequence(Color3fromRGB(192, 192, 192)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Wire.rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Wire.db,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Wire.ft,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Wire.rpg,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[SMG]'] = {
                    equipped = false,
                    location = meshes.Wire.smg,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['SoulII'] = {
            color = newColorSequence(Color3fromRGB(138, 43, 226)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.SoulII.rev,
                    C0 = newCFrame(0, -0.152932271, -0.0446666516, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Portal'] = {
            color = newColorSequence(Color3fromRGB(0, 128, 255)),
            guns = {
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Portal.Tact,
                    C0 = newCFrame(0.399230957, 0.352560997, -0.0200195312, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Portal.rev,
                    C0 = newCFrame(0.286621094, 0.293630004, 0.0108032227, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Portal.DB,
                    C0 = newCFrame(0.272399902, 0.387924969, 0.0036315918, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                }
            }
        },

        ['Military'] = {
            color = newColorSequence(Color3fromRGB(85, 107, 47)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Military.Rev,
                    C0 = newCFrame(-0.0182495117, -0.163827896, 0.127151489, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Military.Tact,
                    C0 = newCFrame(-0.160217285, -0.0670479834, 1.13010406, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07)
                },
                ['[AUG]'] = {
                    equipped = false,
                    location = meshes.Military.Aug,
                    C0 = newCFrame(-0.144897461, 0.0915043354, -0.906417847, -1.1920929e-07, 0, -1.00000012, 0, 1, 0, 1.00000012, 0, -1.1920929e-07)
                }
            }
        },

        ['gothic'] = {
            color = newColorSequence(Color3fromRGB(75, 0, 130)),
            guns = {
                ['[DrumGun]'] = {
                    equipped = false,
                    location = meshes.gothic.Drum,
                    C0 = newCFrame(0.0176869724, 0.160771817, -0.00803953223, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.gothic.Rev,
                    C0 = newCFrame(0.403213918, 0.0601887107, -0.000585322385, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.gothic.db,
                    C0 = newCFrame(0.106559344, -0.168828204, 0.0150288427, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.gothic.rpg,
                    C0 = newCFrame(0.131347656, 0.401780963, 0.0192260742, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Spectre'] = {
            color = newColorSequence(Color3fromRGB(147, 112, 219)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Spectre.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['CandyCane'] = {
            color = newColorSequence(Color3fromRGB(255, 0, 0)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.CandyCane.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Butterfly'] = {
            color = newColorSequence(Color3fromRGB(255, 192, 203)),
            guns = {
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Butterfly.DB,
                    C0 = newCFrame(0.180474043, -0.132168204, 0.0303655267, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Butterfly.Rev,
                    C0 = newCFrame(-0.134230286, -0.105021089, -0.0369957983, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['GPO'] = {
            color = newColorSequence(Color3fromRGB(135, 206, 235)),
            guns = {
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.GPO.MaguTact,
                    C0 = newCFrame(0.00122070312, 0.202483177, -1.02368164, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.GPO.Bazooka,
                    C0 = newCFrame(0.0462341309, 0.192625999, -0.000244140625, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                },
                ['[AK47]'] = {
                    equipped = false,
                    location = meshes.GPO.Rifle,
                    C0 = newCFrame(-0.750015259, 4.76837158e-07, -3.05175781e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['XMAS24'] = {
            color = newColorSequence(Color3fromRGB(255, 255, 255)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.XMAS24.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[AK47]'] = {
                    equipped = false,
                    location = meshes.XMAS24.AK,
                    C0 = newCFrame(-0.750015259, 4.76837158e-07, -3.05175781e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.XMAS24.Flamethrower,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Grumpy'] = {
            color = newColorSequence(Color3fromRGB(139, 69, 19)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Grumpy.rev,
                    C0 = newCFrame(-0.000915527344, 0.217945307, -0.301389694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Rifle]'] = {
                    equipped = false,
                    location = meshes.Grumpy.rifle,
                    C0 = newCFrame(-0.0048828125, -0.118600696, 0.498569489, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[LMG]'] = {
                    equipped = false,
                    location = meshes.Grumpy.lmg,
                    C0 = newCFrame(-0.00100889429, 0.33378312, -0.316355616, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Wrapped'] = {
            color = newColorSequence(Color3fromRGB(255, 215, 0)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Wrapped.WrappedRev,
                    C0 = newCFrame(0.407029152, 0.188748091, -0.00524902344, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Shrimp'] = {
            color = newColorSequence(Color3fromRGB(255, 127, 80)),
            guns = {
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Shrimp.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Shrimp.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.Shrimp.Flamethrower,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Shrimp.RPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['VIP'] = {
            color = newColorSequence(Color3fromRGB(255, 0, 127)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.VIP.rev,
                    C0 = newCFrame(0, 0.108577728, -0.125549316, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Rifle]'] = {
                    equipped = false,
                    location = meshes.VIP.rifle,
                    C0 = newCFrame(-0.955810547, -0.0458688736, 0.0255126953, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes.VIP.ft,
                    C0 = newCFrame(-0.128173828, -0.383542061, -0.159667969, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                }
            }
        },

        ['ShortCake'] = {
            color = newColorSequence(Color3fromRGB(255, 182, 193)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes['Short Cake'].rev,
                    C0 = newCFrame(-0.002770263, 0.352979064, -0.830832243, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes['Short Cake'].DB,
                    C0 = newCFrame(0.128234863, 0.315840125, 0.51071167, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[Flamethrower]'] = {
                    equipped = false,
                    location = meshes['Short Cake'].ft,
                    C0 = newCFrame(0, 0.510873735, 1.18507099, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes['Short Cake'].rpg,
                    C0 = newCFrame(0.323059082, -0.293833196, -0.0293579102, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Beary'] = {
            color = newColorSequence(Color3fromRGB(139, 69, 19)),
            guns = {
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Beary.RPG,
                    C0 = newCFrame(0.128905624, -0.312884778, -0.00511842454, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Beary.DB,
                    C0 = newCFrame(-5.96046448e-08, -0.0590882003, -0.638539672, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Beary.Tac,
                    C0 = newCFrame(0.957006454, -0.0858021975, -5.96046448e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Beary.Rev,
                    C0 = newCFrame(-0.00620785356, -0.174215302, 0.261013985, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Sushi'] = {
            color = newColorSequence(Color3fromRGB(255, 105, 180)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Sushi.Rev,
                    C0 = newCFrame(-0.0666576028, 0.00443099439, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Sushi.DB,
                    C0 = newCFrame(-0.0924364328, 0.0200210214, -0.00109639764, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Sushi.Tact,
                    C0 = newCFrame(0.122369051, -0.261870563, 1.49011612e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Sushi.RPG,
                    C0 = newCFrame(-0.0865417719, -0.00205504894, 1.63912773e-07, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Arcane'] = {
            color = newColorSequence(Color3fromRGB(138, 43, 226)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Arcane.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Kingpin'] = {
            color = newColorSequence(Color3fromRGB(218, 165, 32)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Kingpin.Rev,
                    C0 = newCFrame(0, 0.396745056, 0.0234680176, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Kingpin.DB,
                    C0 = newCFrame(0, 0.110570669, 0.260955811, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[AK47]'] = {
                    equipped = false,
                    location = meshes.Kingpin.AK,
                    C0 = newCFrame(-0.750015259, 4.76837158e-07, -3.05175781e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Bubu'] = {
            color = newColorSequence(Color3fromRGB(255, 192, 203)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Bubu.Rev,
                    C0 = newCFrame(0.049242083, -0.210244983, -0.140570492, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Music'] = {
            color = newColorSequence(Color3fromRGB(138, 43, 226)),
            guns = {
                ['[DrumGun]'] = {
                    equipped = false,
                    location = meshes.Music.Drum,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Music.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Music.RPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Music.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Brainrot'] = {
            color = newColorSequence(Color3fromRGB(64, 224, 208)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Brainrot.Rev,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Brainrot.DB,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Brainrot.Tac,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Brainrot.RPG,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    equipped = false,
                    location = meshes.Brainrot.Shotgun,
                    C0 = newCFrame(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Ribbon'] = {
            color = newColorSequence(Color3fromRGB(255, 105, 180)),
            guns = {
                ['[RPG]'] = {
                    equipped = false,
                    location = meshes.Ribbon.RPG,
                    C0 = newCFrame(-0.016628243, 0.234403983, -1.06992698, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Ribbon.Rev,
                    C0 = newCFrame(-0.0929494798, 0.0351079628, -0.018664673, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['Popular'] = {
            color = newColorSequence(Color3fromRGB(0, 191, 255)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Popular.VERIFIEDREV,
                    C0 = newCFrame(0.463653564, 0.220754623, 0.000823974609, -0.999450922, 0, 0.0331431068, 0, 1, 0, -0.0331431068, 0, -0.999450922)
                }
            }
        },

        ['Heaven'] = {
            color = newColorSequence(Color3fromRGB(255, 255, 255)),
            guns = {
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Heaven.DB,
                    C0 = newCFrame(-0.146379977, 0.0462858491, -4.14791684e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Heaven.Revolver,
                    C0 = newCFrame(0.0164489746, 0.016949296, -0.000305175781, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['WildWest'] = {
            color = newColorSequence(Color3fromRGB(205, 133, 63)),
            guns = {
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.WildWest.DB,
                    C0 = newCFrame(-0.104217529, 0.440151036, 1.26495361, 0, 0, -1, 0, -1, -0, -1, 0, -0)
                },
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.WildWest.Rev,
                    C0 = newCFrame(0.000427246094, 0.0195280313, 0.117950439, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },

        ['IcedOut'] = {
            color = newColorSequence(Color3fromRGB(0, 191, 255)),
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.IcedOut.rev,
                    C0 = newCFrame(0.0102539062, 0.292739868, -0.310405731, 0, 1, -0, -1, 0, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.IcedOut.db,
                    C0 = newCFrame(0, 0.24049142, -0.128397882, -1.02519989e-05, 1, -6.55651093e-07, -0.991971493, -1.02519989e-05, -0.126462117, -0.126462117, -6.55651093e-07, 0.991971433)
                }
            }
        }
    };

    mkelement = function(class, parent, props)
        local obj = Instance.new(class);

        for i, v in next, props do
            obj[i] = v;
        end;

        obj.Parent = parent;
        return obj;
    end;

    find_gun = (function(gun_name, instance)
        for i, v in next, instance:GetChildren() do
            if v:IsA('Tool') then
                if (v.Name == gun_name) then
                    return v
                end
            end
        end
    end);

    InventoryChanger.Functions.GameEquip = function(gun, skin)
        return replicated_storage.MainEvent:FireServer('EquipWeaponSkins', gun, skin);
    end;

    InventoryChanger.Functions.AddOwnedSkins = function()
        for _, v in ipairs(entries:GetChildren()) do
            local ext_name = v.Name:match('%[(.-)%]');
            local skin_name, _ = v.Name:gsub('%[.-%]', '');
            if 
                ext_name 
                and skin_name 
                and InventoryChanger.Skins[skin_name] 
                and InventoryChanger.Skins[skin_name].guns 
                and InventoryChanger.Skins[skin_name].guns['[' .. ext_name .. ']']
            then
                local Preview = v:FindFirstChild('Preview');

                if Preview and Preview:FindFirstChild('Equipped') and Preview.Equipped.Visible then
                    table.insert(InventoryChanger.Owned, { frame = v, gun = '[' .. ext_name .. ']' })
                end;
            end;
        end;
    end;

    InventoryChanger.Functions.UnequipGameSkins = function()
        for _, v in ipairs(InventoryChanger.Owned) do
            local SkinInfo = v.frame.SkinInfo;
            local Container = SkinInfo.Container;
            local SkinName = Container.SkinName.Text;

            InventoryChanger.Functions.GameEquip(v.gun, SkinName)
        end;
    end;

    InventoryChanger.Functions.Unload = function()
        return Utilities.Unload();
    end;

    InventoryChanger.Functions.Reload = function()
        local function wait_for_child(parent, child)
            local child = parent:WaitForChild(child);
            while not child do
                child = parent:WaitForChild(child);
            end;
            return child;
        end;
        
        client = players.LocalPlayer;
        player_gui = client.PlayerGui;

        repeat task.wait() until player_gui;

        main_gui = wait_for_child(player_gui, 'MainScreenGui');
        crew = wait_for_child(main_gui, 'Crew');

        bottom_left = wait_for_child(crew, 'BottomLeft');
        bottom_left = bottom_left.Frame;

        skins_button = wait_for_child(bottom_left, 'Skins');

        weapon_skins_gui = wait_for_child(main_gui, 'WeaponSkinsGUI');
        
        gui_body_wrapper = wait_for_child(weapon_skins_gui, 'Body');
        body_wrapper = wait_for_child(gui_body_wrapper, 'Wrapper');
        
        skin_view = wait_for_child(body_wrapper, 'SkinView');
        skin_view_frame = wait_for_child(skin_view, 'Frame');

        guns = wait_for_child(skin_view_frame, 'Guns').Contents;
        entries = wait_for_child(skin_view_frame, 'Skins').Contents.Entries;

        InventoryChanger.Functions.Unload();

        cout('Reload', 'Botnets are opening');
        cout('Reload', 'Niggas are ddosd');

        wait_for_child(entries, '[Revolver]Golden Age');

        cout('Reload', 'Niggas successfully ddosd.');
        InventoryChanger.Functions.AddOwnedSkins();
        InventoryChanger.Functions.UnequipGameSkins();

        for i, v in next, guns:GetChildren() do
            if v:IsA('Frame') and v.Name ~= 'GunEntry' and v.Name ~= 'Trading' and v.Name ~= '[Mask]' then
                Utilities.AddConnection(v.Button.MouseButton1Click, function()
                    local extracted_name = v.Name:match(regex);
                    if extracted_name then
                        InventoryChanger.Functions.Start(extracted_name);
                    end;
                end);
            end;
        end;
    end;

    InventoryChanger.Functions.Equip = function(gun_name, skin_name)
        print('[DEBUG]', 'Equip function has been invoked.', gun_name, skin_name or 'Default')
        local gun = find_gun(gun_name, client.Backpack) or find_gun(gun_name, client.Character);
        if not skin_name then
            if gun and gun.Name == gun_name then
                for _, v in next, gun.Default:GetChildren() do v:Destroy() end;
                
                gun.Default.Transparency = 0;
                --if InventoryChanger.Selected[gun.Name] and not InventoryChanger.Skins[InventoryChanger.Selected[gun.Name]].Location then
                    --gun.Default.TextureID = 'rbxassetid://8117372147';
                --end;
                
                if gun.Name == '[Silencer]' or gun.Name == '[SilencerAR]' then
                    gun:FindFirstChild('Part').Transparency = 0;
                end;

                local skin_name = InventoryChanger.Selected[gun.Name];

                if skin_name and InventoryChanger.Skins[skin_name] and InventoryChanger.Skins[skin_name].guns and InventoryChanger.Skins[skin_name].guns[gun.Name] then
                    if InventoryChanger.Skins[skin_name].guns[gun.Name].TracerLoop then
                        InventoryChanger.Skins[skin_name].guns[gun.Name].TracerLoop:Disconnect();
                        InventoryChanger.Skins[skin_name].guns[gun.Name].TracerLoop = nil;
                    end;

                    if InventoryChanger.Skins[skin_name].guns[gun.Name].shoot_sound_loop then
                        InventoryChanger.Skins[skin_name].guns[gun.Name].shoot_sound_loop:Disconnect();
                        InventoryChanger.Skins[skin_name].guns[gun.Name].shoot_sound_loop = nil;
                    end;
                end;
            end;

            return;
        end;
        
        if gun and gun.Name == gun_name and skin_name then
            cout('DEBUG', 'Has skin name');
            local skin_pack = InventoryChanger.Skins[skin_name];
            local guns = skin_pack.guns;
            if skin_pack and guns and not skin_pack.texture then
                cout('DEBUG', 'Changing skin assets');
                for _, x in next, gun.Default:GetChildren() do x:Destroy() end;
                
                local clone = guns[gun_name].location:Clone();
                clone.Name = 'Mesh';
                clone.Parent = gun.Default;
                
                local weld = Instance.new('Weld', clone);
                weld.Part0 = gun.Default;
                weld.Part1 = clone;
                weld.C0 = guns[gun_name].C0;
                
                gun.Default.Transparency = 1;

                if guns[gun_name].shoot_sound then
                    if guns[gun_name].shoot_sound_loop then
                        guns[gun_name].shoot_sound_loop:Disconnect();
                        guns[gun_name].shoot_sound_loop = nil;
                    end;
                    gun.Handle.ShootSound.SoundId = guns[gun_name].shoot_sound;
                    guns[gun_name].shoot_sound_loop = gun.Handle.ChildAdded:Connect(function(child)
                        if child:IsA('Sound') and child.Name == 'ShootSound' then
                            child.SoundId = guns[gun_name].shoot_sound;
                        end;
                    end);
                end;
            end;
        end;
    end;

    InventoryChanger.Functions.Start = function(name)
        for i, v in next, entries:GetChildren() do
            local skin_name, _ = v.Name:gsub('%[.-%]', '');

            if string.find(v.Name, name, 1, true) and InventoryChanger.Skins[skin_name] and InventoryChanger.Skins[skin_name].guns and InventoryChanger.Skins[skin_name].guns['['..name..']'] and InventoryChanger.Skins[skin_name].guns['['..name..']'].location then
                local Preview = v:FindFirstChild('Preview');
                local Button = v:FindFirstChild('Button');
                local skinInfo = v:FindFirstChild('SkinInfo');

                if Preview and Button and skinInfo then
                    local Label = Preview:FindFirstChild('LockImageLabel');
                    local AmountValue = Preview:FindFirstChild('AmountValue');
                    local Equipped = Preview:FindFirstChild('Equipped');
                    local container = skinInfo:FindFirstChild('Container');

                    local extracted_name = v.Name:match(regex);

                    if Equipped and extracted_name then
                        Equipped.Visible = InventoryChanger.Skins[skin_name] and InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'] and InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped or false;
                        InventoryChanger.Functions.Equip('['..extracted_name..']', InventoryChanger.Selected['['..extracted_name..']'])

                        if Label then
                            Label.Visible = false;
                        end;

                        if container and container.SellButton then
                            container.SellButton.Visible = true;
                        end;
                    
                        if AmountValue then
                            AmountValue.Visible = true;
                            AmountValue.Text = 'x1';
                        end;
                    
                        if getgenv().InventoryConnections[v.Name] then
                            getgenv().InventoryConnections[v.Name]:Disconnect();
                            getgenv().InventoryConnections[v.Name] = nil;
                        end;

                        v.Button:Destroy();
                        local props = { Text = '',BackgroundTransparency = 1,Size = UDim2.new(1, 0, 0.7, 0),ZIndex = 5,Name = 'Button',Position = UDim2.new(0, 0, 0, 0)};
                        local new_btn = mkelement('TextButton', v, props);

                        getgenv().InventoryConnections[v.Name] = new_btn.MouseButton1Click:Connect(function()
                            InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped = not InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped;
                            InventoryChanger.Selected['['..extracted_name..']'] = InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped and skin_name or nil;
                            Equipped.Visible = InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped;

                            for k, x in ipairs(entries:GetChildren()) do
                                if x.Name:match(regex) == extracted_name and x ~= v then
                                    x.Preview.Equipped.Visible = false;

                                    for _, l in next, InventoryChanger.Skins do
                                        if _ ~= skin_name and l['['..extracted_name..']'] and l['['..extracted_name..']'].equipped then
                                            l[extracted_name].equipped = false
                                        end;
                                    end;
                                end;
                                
                                if x ~= v and string.find(x.Name, name, 1, true) and InventoryChanger.Skins[skin_name] and InventoryChanger.Skins[skin_name].guns and InventoryChanger.Skins[skin_name].guns['['..name..']'] and InventoryChanger.Skins[skin_name].guns['['..name..']'].location then
                                    local Preview = v:FindFirstChild('Preview');
                                    local Button = v:FindFirstChild('Button');
                                    local skinInfo = v:FindFirstChild('SkinInfo');
                                    
                                    if Preview and Button and skinInfo then
                                        local Label = Preview:FindFirstChild('LockImageLabel');
                                        local AmountValue = Preview:FindFirstChild('AmountValue');
                                        local Equipped = Preview:FindFirstChild('Equipped');
                                        local container = skinInfo:FindFirstChild('Container');
                                        
                                        if Label then
                                            Label.Visible = false;
                                        end;
                        
                                        if container and container.SellButton then
                                            container.SellButton.Visible = true;
                                        end;
                                        
                                        if AmountValue then
                                            AmountValue.Visible = true;
                                            AmountValue.Text = 'x1';
                                        end;
                                    end;

                                    InventoryChanger.Owned = {};
                                    InventoryChanger.Functions.AddOwnedSkins();
                                    InventoryChanger.Functions.UnequipGameSkins();
                                end;
                            end;
                        end);
                    end;
                end;
            end;
        end;
    end;

    InventoryChanger.Functions.CharacterAdded = function(character)
        if getgenv().InventoryConnections.ChildAdded then
            getgenv().InventoryConnections.ChildAdded:Disconnect();
            getgenv().InventoryConnections.ChildAdded = nil;
        end;

        if getgenv().InventoryConnections.ChildRemoved then
            getgenv().InventoryConnections.ChildRemoved:Disconnect();
            getgenv().InventoryConnections.ChildRemoved = nil;
        end;

        getgenv().InventoryConnections.ChildAdded = character.ChildAdded:Connect(function(child)
            if child:IsA('Tool') and child:FindFirstChild('GunScript') then
                InventoryChanger.Functions.Equip(child.Name, InventoryChanger.Selected[child.Name]);
                local skin_name = InventoryChanger.Selected[child.Name];
                
                if skin_name then
                    if InventoryChanger.Skins[skin_name].color and InventoryChanger.Skins[skin_name].guns[child.Name].equipped then
                        if InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop then
                            InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop:Disconnect();
                            InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop = nil;
                        end;

                        InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop = Ignored.DescendantAdded:Connect(function(descendant)
                            local gun = find_gun(child.Name, client.Character) or nil;

                            if gun and descendant:IsDescendantOf(siren) and descendant:IsA('Beam') then
                                local pos1 = (descendant.Attachment0.WorldCFrame.Position.X > gun.Handle.CFrame.Position.X) and descendant.Attachment0.WorldCFrame.Position or gun.Handle.CFrame.Position;
                                local pos2 = (descendant.Attachment0.WorldCFrame.Position.X < gun.Handle.CFrame.Position.X) and descendant.Attachment0.WorldCFrame.Position or gun.Handle.CFrame.Position;

                                if math.abs(client.Character.HumanoidRootPart.Velocity.X) < 22 and (pos1 - pos2).Magnitude < 5 or (pos1 - pos2).Magnitude < 20 then
                                    local skin_pack = InventoryChanger.Skins[skin_name];
                                    local guns = skin_pack and skin_pack.guns or nil
                                    local tween_duration = skin_pack and (skin_pack.tween_duration or guns and guns[gun.Name] and guns[gun.Name].tween_duration) or nil;
                                    local width = skin_pack and (skin_pack.beam_width or guns and guns[gun.Name] and guns[gun.Name].beam_width) or nil;
                                    local color = skin_pack and (skin_pack.color or guns and guns[gun.Name] and guns[gun.Name].color) or nil;
                                    local easing_direction = skin_pack and (skin_pack.easing_direction or guns and guns[gun.Name] and guns[gun.Name].easing_direction) or nil;
                                    local easing_style = skin_pack and (skin_pack.easing_style or guns and guns[gun.Name] and guns[gun.Name].easing_style) or nil;

                                    if skin_pack and tween_duration and color then
                                        local clonedParent = descendant.Parent:Clone();

                                        clonedParent.Parent = workspace.Vehicles;
                                        descendant.Parent:Destroy();
                                        if width then
                                            clonedParent:FindFirstChild('GunBeam').Width1 = width;
                                        end;
                                        clonedParent:FindFirstChild('GunBeam').Color = color;
                                        Utilities.Tween({
                                            object = clonedParent:FindFirstChild('GunBeam'),
                                            info = { tween_duration, easing_style, easing_direction },
                                            properties = { Width1 = 0 },
                                            callback = function()
                                                clonedParent:Destroy();
                                            end
                                        })
                                    elseif color then
                                        descendant.Color = color;
                                    end;
                                end;
                            end;
                        end);
                    else
                        if InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop then
                            InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop:Disconnect();
                            InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop = nil;
                        end;
                    end;
                end;
            end;
        end);

        getgenv().InventoryConnections.ChildRemoved = character.ChildRemoved:Connect(function(child)
            if child:IsA('Tool') and child:FindFirstChild('GunScript') then
                InventoryChanger.Functions.Equip(child.Name, false);

                local skin_name = InventoryChanger.Selected[child.Name];

                if skin_name then
                    if InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop then
                        InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop:Disconnect();
                        InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop = nil;
                    end;
                end;
            end;
        end);
        
        InventoryChanger.Functions.Reload();
    end;

    if getgenv().InventoryConnections.CharacterAdded then
        getgenv().InventoryConnections.CharacterAdded:Disconnect();
        getgenv().InventoryConnections.CharacterAdded = nil;
    end;
    getgenv().InventoryConnections.CharacterAdded = client.CharacterAdded:Connect(InventoryChanger.Functions.CharacterAdded);    InventoryChanger.Functions.CharacterAdded(client.Character);end;