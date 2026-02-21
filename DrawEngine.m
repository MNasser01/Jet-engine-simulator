function DrawEngine(To, Tt2, Tt3, T4, Tt9)
    % التأكد من وجود قيم مدخلة للتجربة
    if nargin < 5, To=300; Tt2=300; Tt3=620; T4=1500; Tt9=850; end

    % 1. إعداد الشكل (خلفية داكنة احترافية)
    hFig = figure('Name', 'Dynamic Turbojet Engine Simulator', 'Color', [0.05 0.05 0.05], ...
                  'Position', [50 50 1000 550], 'MenuBar', 'none', 'NumberTitle', 'off'); 
    ax = axes('Parent', hFig, 'Color', 'none', 'XColor', 'w', 'YColor', 'w');
    hold(ax, 'on'); axis(ax, 'equal'); grid(ax, 'off');
    
    % --- 2. وهج العادم (Exhaust Glow) ---
    glow_x = [10.5 14 14 10.5];
    glow_y = [0.6 1.5 -1.5 -0.6];
    hGlow = fill(ax, glow_x, glow_y, [1 0.25 0], 'EdgeColor', 'none', 'FaceAlpha', 0.3);

    % --- 3. أجزاء المحرك الثابتة ---
    fill(ax, [0.5 2 2 0.5], [0 0.8 -0.8 0], [0.5 0.5 0.5], 'EdgeColor', 'w'); % Nose
    fill(ax, [4 7 7 4], [0.5 0.5 -0.5 -0.5], [0.7 0.1 0.1], 'EdgeColor', 'w'); % Combustor
    fill(ax, [8.5 10.5 10.5 8.5], [1.1 0.6 -0.6 -1.1], [0.2 0.2 0.2], 'EdgeColor', 'w'); % Nozzle
    fill(ax, [2 4 4 2], [1.2 0.8 -0.8 -1.2], [0.1 0.3 0.5], 'EdgeColor', 'w', 'LineWidth', 1.2); % Compressor
    fill(ax, [7 8.5 8.5 7], [0.8 1.1 -1.1 -0.8], [0.15 0.15 0.15], 'EdgeColor', 'w', 'LineWidth', 1.2); % Turbine

    % --- 4. العداد الحراري لـ T4 ---
    rectangle(ax, 'Position', [4.5, -2.8, 3, 0.4], 'EdgeColor', 'w', 'LineWidth', 1);
    t4_ratio = min(T4/2000, 1);
    rectangle(ax, 'Position', [4.5, -2.8, t4_ratio*3, 0.4], 'FaceColor', 'r', 'EdgeColor', 'none');
    text(ax, 6, -3.2, 'TURBINE INLET TEMPERATURE (T4)', 'Color', 'w', 'HorizontalAlignment', 'center', 'FontSize', 9);

    % --- 5. الأسهم والبيانات (Station Tags) ---
    drawSmartTag(ax, 1.1, 2.2, 'T0', To, [0.5 0.7 1]);   
    drawSmartTag(ax, 2.1, 3.3, 'T2', Tt2, [0.3 0.8 1]);   
    drawSmartTag(ax, 4.0, 2.2, 'T3', Tt3, [0.4 1.0 0.4]); 
    drawSmartTag(ax, 7.0, 3.3, 'T4', T4, [1.0 0.4 0.4]); 
    drawSmartTag(ax, 10.0, 2.2, 'T9', Tt9, [0.8 0.8 0.8]); 

    % --- 6. ريش الضاغط (Rotors) ---
    x_s = linspace(2, 4, 6); comp_blades = [];
    for i = 1:5
        xm = (x_s(i)+x_s(i+1))/2; hb = 1.2-(xm-2)*0.2;
        for yo = linspace(-hb+0.3, hb-0.3, 4)
            h = line(ax, [xm-0.05 xm+0.05], [yo-0.08 yo+0.08], 'Color', 'c', 'LineWidth', 1.8);
            comp_blades = [comp_blades, h];
        end
    end

    % --- 7. ريش التوربينة (Rotors) ---
    x_t = linspace(7, 8.5, 3); turb_blades = [];
    for i = 1:2
        xtm = (x_t(i)+x_t(i+1))/2; htb = 0.8+(xtm-7)*0.2;
        for yto = linspace(-htb+0.3, htb-0.3, 3)
            h_t = line(ax, [xtm-0.05 xtm+0.05], [yto+0.08 yto-0.08], 'Color', [1 0.8 0], 'LineWidth', 1.8);
            turb_blades = [turb_blades, h_t];
        end
    end

    xlim(ax, [0 15]); ylim(ax, [-5 5]); set(ax, 'Visible', 'off');
    title(ax, 'REAL-TIME PROPULSION SYSTEM VISUALIZER', 'Color', 'w', 'FontSize', 14, 'FontWeight', 'bold');
    
    % --- Animation Loop ---
    offset = 0;
    while ishandle(hFig)
        % تحريك الضاغط
        idx = 1;
        for i = 1:5
            xm = (x_s(i)+x_s(i+1))/2; hb = 1.2-(xm-2)*0.2;
            y_base = linspace(-hb+0.3, hb-0.3, 4);
            for yo = y_base
                new_y = mod(yo + offset + (hb-0.3), 2*(hb-0.3)) - (hb-0.3);
                set(comp_blades(idx), 'YData', [new_y-0.08 new_y+0.08]);
                idx = idx + 1;
            end
        end

        % تحريك التوربينة
        idx_t = 1;
        for i = 1:2
            xtm = (x_t(i)+x_t(i+1))/2; htb = 0.8+(xtm-7)*0.2;
            y_base_t = linspace(-htb+0.3, htb-0.3, 3);
            for yto = y_base_t
                new_y_t = mod(yto - offset*1.6 + (htb-0.3), 2*(htb-0.3)) - (htb-0.3);
                set(turb_blades(idx_t), 'YData', [new_y_t+0.08 new_y_t-0.08]);
                idx_t = idx_t + 1;
            end
        end

        % نبض وهج العادم
        set(hGlow, 'FaceAlpha', 0.15 + 0.2*sin(offset*10)^2);
        
        offset = offset + 0.045;
        drawnow limitrate;
        pause(0.015);
        if ~ishandle(hFig), break; end
    end
end

function drawSmartTag(ax, x, y_start, labelStr, val, color)
    target_y = 0.8;
    quiver(ax, x, y_start, 0, -(y_start-target_y-0.1), 0, 'Color', color, 'LineWidth', 1.6, 'MaxHeadSize', 0.4);
    text(ax, x, y_start + 0.4, sprintf('%s: %.1f K', labelStr, val), 'FontSize', 10, ...
        'Color', color, 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
end