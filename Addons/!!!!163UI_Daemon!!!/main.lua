
SetAddonVersionCheck(false);

local version, build, complied_time, toc = GetBuildInfo();
if toc > 90001 then
    EnableAddOn("!!!163UI!!!");
    LoadAddOn("!!!163UI!!!");
end
