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
load rain48h;
load snow48h;

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
load rain7d;
load snow7d;

dt48h = dt48h / 86400 + datenum (1970,1,1);

for a = 1 : 48
    if rain48h(a) == 0; rain48h(a) = NaN; endif;
    if snow48h(a) == 0; snow48h(a) = NaN; endif;
endfor
for a = 1 : 8
    if rain7d(a) == 0; rain7d(a) = NaN; endif;
    if snow7d(a) == 0; snow7d(a) = NaN; endif;
endfor
clear a
a = max(max(rain48h),max(snow48h));
s = max(max(rain7d),max(snow7d));
rain48h *= 100 / a;
snow48h *= 100 / a;
rain7d *= 100 / s;
snow7d *= 100 / s;


figure 1;
subplot (3, 3, 1:6);
ax = plot (dt48h, temp48h, "r;Temperature, °C;", dt48h, feels_like48h, "g;Feels like, °C;", dt48h, dew_point48h, "b;Dew point, °C;");
grid minor; axis tight; box on;
dateaxis ('x', '%d.');
title ('48h forecast');
set (ax, "linewidth", 2); 
set (gca, 'fontsize',12,'fontweight','bold'); 



% figure 2;
subplot (3, 3, 7:9);
hold on;
plot (dt48h, clouds48h, "k", "linewidth", 2); dateaxis ('x', '%d.'); 
[ax1, h1, h2] = plotyy (dt48h, humidity48h, dt48h, pressure48h);
ylabel (ax1(1), sprintf('Relative humidity, %%\nRain/Snow w/ max %2.2f, mm', a));
ylabel (ax1(2), 'Pressure AGL, mbar');
[ax2, h3, h4] = plotyy (dt48h, rain48h, dt48h, snow48h);
for a=[1 2];xlabel (ax1(a), 'UTC'); endfor;
for a=[1 2];xlabel (ax2(a), 'UTC'); endfor;
legend ('Cloud coverage, %', 'Relative humidity, %', 'Rain, % of max', 'Atmospheric pressure, mbar', 'Snow, % of max')
grid minor; axis tight; dateaxis (ax1(1), 'x', '%d.'); dateaxis (ax1(2), 'x', '%d.');  dateaxis (ax2(1), 'x', '%d.'); dateaxis (ax2(2), 'x', '%d.'); 
set (ax1(:),'fontsize', 12, 'fontweight', 'bold');
set (ax2(:),'fontsize', 12, 'fontweight', 'bold');
set(ax2(1),'ycolor','b')
set(ax2(2),'ycolor','y')
set (h3, 'Color', 'c'); set (h4, 'Color', 'g');
set ([h1 h2 h3 h4], 'linewidth', 2);



figure 3;
subplot (3, 3, 1:6);
ax = plot (1:8, min7d, '--k;min7d;', 1:8, max7d, '--k;max7d;', 1:8, morn7d, '*c;morn7d;', 1:8, flmorn7d, '-c;flmorn7d;', 1:8, day7d, 'xr;day7d;', 1:8, flday7d, '-r;flday7d;', 1:8, eve7d, 'og;eve7d;', 1:8, fleve7d, '-g;fleve7d;', 1:8, night7d, '+b;night7d;', 1:8, flnight7d, '-b;flnight7d;');
grid minor; axis tight; box on;
title ('7d forecast');
set (ax, "linewidth", 2); 
set (gca, 'fontsize',12,'fontweight','bold'); 



% figure 4;
subplot (3, 3, 7:9);
hold on;
plot (1:8, clouds7d, 'k;Cloud coverage, %;', "linewidth", 2);
[ax1, h1, h2] = plotyy (1:8, humidity7d, 1:8, pressure7d);
ylabel (ax1(1), sprintf('Relative humidity, %%\nRain/Snow w/ max %2.2f, mm', s));
ylabel (ax1(2), 'Pressure AGL, mbar');
[ax2, h3, h4] = plotyy (1:8, rain7d, 1:8, snow7d);
for a=[1 2]; xlabel (ax1(a), '1 = current day'); endfor;
for a=[1 2]; xlabel (ax2(a), '1 = current day'); endfor;
legend (h3, 'Rain'); legend (h4, 'Snow');
grid minor; axis tight;
set (ax1(:),'fontsize', 12, 'fontweight', 'bold');
set (ax2(:),'fontsize', 12, 'fontweight', 'bold');
set(ax2(1),'ycolor','b')
set(ax2(2),'ycolor','y')
set (h3, 'Color', 'c'); set (h4, 'Color', 'g');
set ([h1 h2 h3 h4], 'linewidth', 2);


return;
