pkg load financial;
cd /tmp/wdr;

load dt48h;
load temp48h;
load feels_like48h;
load dew_point48h;
load pressure48h;
load humidity48h;
load clouds48h;
load wind_speed48h;
load wind_deg48h;

load min7d;
load max7d;
load morn7d;
load day7d;
load eve7d;
load night7d;
load flmorn7d;
load flday7d;
load fleve7d;
load flnight7d;

load pressure7d;
load humidity7d;
load clouds7d;
load dew_point7d;
load wind_deg7d;
load wind_speed7d;

dt48h=dt48h/86400 + datenum(1970,1,1);


figure 1;
subplot (3, 3, 1:6);
ax = plot (dt48h, temp48h, "r;Temperature, °C;", dt48h, feels_like48h, "g;Feels like, °C;", dt48h, dew_point48h, "b;Dew point, °C;");
grid minor; axis tight; box on;
dateaxis ('x', '%d.');
title ('48h forecast');
set (ax, "linewidth", 2); 
set (gca, 'fontsize',14,'fontweight','bold'); 


% figure 2;
subplot (3, 3, 7:9);
plot (dt48h, clouds48h, "k;Cloud coverage, %;", "linewidth", 2); hold on; [ax, h1, h2] = plotyy (dt48h, humidity48h, dt48h, pressure48h, @plot, @plot); ylabel (ax(1), "Relative humidity, %"); ylabel (ax(2), "Pressure AGL, mbar"); for a=[1 2]; xlabel (ax(a), 'UTC'); endfor;
grid minor;
dateaxis ('x', '%d.');
% title ('48h forecast');
set (ax(:),'fontsize', 14, 'fontweight', 'bold');
set ([h1 h2], 'linewidth', 2);


figure 3;
subplot (3, 3, 1:6);
ax = plot (1:8, min7d, '--k;min7d;', 1:8, max7d, '--k;max7d;', 1:8, morn7d, '*c;morn7d;', 1:8, flmorn7d, '-c;flmorn7d;', 1:8, day7d, 'xr;day7d;', 1:8, flday7d, '-r;flday7d;', 1:8, eve7d, 'og;eve7d;', 1:8, fleve7d, '-g;fleve7d;', 1:8, night7d, '+b;night7d;', 1:8, flnight7d, '-b;flnight7d;');
grid minor; axis tight; box on;
title ('7d forecast');
set (ax, "linewidth", 2); 
set (gca, 'fontsize',14,'fontweight','bold'); 


% figure 4;
subplot (3, 3, 7:9);
plot (1:8, clouds7d, 'k;Cloud coverage, %;', "linewidth", 2); hold on; [ax, h1, h2] = plotyy (1:8, humidity7d, 1:8, pressure7d, @plot, @plot); ylabel (ax(1), 'Relative humidity, %'); ylabel (ax(2), 'Pressure AGL, mbar'); for a=[1 2]; xlabel (ax(a), 'UTC'); endfor
grid minor;
% title ('7d forecast');
set (ax(:),'fontsize', 14, 'fontweight', 'bold');
set ([h1 h2], 'linewidth', 2);

return;
