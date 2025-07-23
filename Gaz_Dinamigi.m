% This code has written by Yavuz Koçak in Matlab.
clc
clear

gamma = 2.43; % Specific Heat ratio (γ); for me 2.43
Ma_1_start=6.01; % First magnitude is 6.01
Ma_1_end=6.50; % Ending value

Ma_1_values=(Ma_1_start:0.01:Ma_1_end); % For me increament is given 0.01, therefor ill define a matrix to calculate the values.
L= length(Ma_1_values);


% This part is just an optimization for code. Not crutial.
Ma_1=zeros(L,1);
Ma_2=zeros(L,1);
P2_P1=zeros(L,1);
T2_T1=zeros(L,1);
Pt2_Pt1=zeros(L,1);
ro2_ro1=zeros(L,1);

% Calculation for every paramaters for every Ma1 number
for i = 1:length(Ma_1_values)

    % For that i define another Ma1 values for simlicity
    Ma_1(i,1)=Ma_1_values(i);

    % With this formula we can calculate de Ma2.
    % I obtain this formula from thermodynamic book, cause in our notes this formula looks too complicated
    Ma_2(i,1)= sqrt( (1 + ((gamma-1)/2)*Ma_1(i)^2)/(gamma*Ma_1(i)^2-((gamma-1)/2)) ); % With this formula we can calculate de Ma2. 
    
    % We optain P2/P1 formula previus lectures 
    P2_P1(i,1)= (1 + gamma *Ma_1(i)^2)/( 1 + gamma* Ma_2(i)^2);

    % Also T2/T1 formulla is found
    T2_T1(i,1)= ( 1+ ((gamma-1)/2) * Ma_1(i)^2 ) / ( 1 + ((gamma-1)/2) * Ma_2(i)^2);

    % Before ro2/ro1 i calculate the Pt2/Pt1 = *** = e^( (-gamma s)/r ) so
    % that *** part we found the P2/P1 needed and we already calculate that
    % part so on we can directly calcualte that part
    Pt2_Pt1(i,1)=P2_P1(i)*( (1+(gamma-1)/2*Ma_2(i)^2)^(gamma/(gamma-1))) / (1+(gamma-1)/2*Ma_1(i)^2)^(gamma/(gamma-1) );

    % At the same time Pt2/Pt1 equals to = e^( (-gamma s)/r ) again we can
    % calculate directly ro2/ro1 
    ro2_ro1(i,1)= Pt2_Pt1(i) * ( (1+(gamma-1)/2*Ma_1(i)^2) / (1+(gamma-1)/2*Ma_2(i)^2) )^(1/(gamma-1));

end

% And now i can make a table for my result.  
% This part nothing but a 5 row after ,
Ma_1 = round(Ma_1, 5);
Ma_2 = round(Ma_2, 5);
P2_P1 = round(P2_P1, 5);
T2_T1 = round(T2_T1, 5);
ro2_ro1 = round(ro2_ro1, 5);
Pt2_Pt1 = round(Pt2_Pt1, 5);


Tablo = table ( ...
    Ma_1,    ...
    Ma_2,    ...
    P2_P1,   ...
    T2_T1,   ...
    ro2_ro1, ...
    Pt2_Pt1, ...
    'VariableNames', {'Ma1','Ma2','P2/P1','T2/T1','ro2/ro1','Pt2/Pt1'} );
disp(Tablo)
writetable(Tablo, 'sonuc_tablo.xlsx'); % Those part is added cause i want the take a copy of graph


% And now its time to graphs
% 1) Ma2 to Ma1
figure;
plot(Ma_1, Ma_2,'r', 'LineWidth', 1.5);
xlabel('Ma_1'); ylabel('Ma_2');
title('Ma_2 to Ma_1');
grid on;

% 2) P2/P1 to Ma1
figure;
plot(Ma_1, P2_P1, 'r', 'LineWidth', 1.5);
xlabel('Ma_1'); ylabel('P_2 / P_1');
title('P_2 / P_1 to Ma_1');
grid on;

% 3) T2/T1 to Ma1
figure;
plot(Ma_1, T2_T1,'r', 'LineWidth', 1.5);
xlabel('Ma1'); ylabel('T2 / T1');
title('T_2 / T_1 to Ma_1');
grid on;

% 4) ro2/ro1 to Ma1
figure;
plot(Ma_1, ro2_ro1,'r', 'LineWidth', 1.5);
xlabel('Ma_1'); ylabel('ro_2 / ro_1');
title('ro_2 / ro_1 to Ma_1');
grid on;

%  Pt2/Pt1 to Ma1
figure;
plot(Ma_1, Pt2_Pt1,'r', 'LineWidth', 1.5);
xlabel('Ma_1'); ylabel('Pa_t_2 / Pa_t_1');
title('Pa_t_2/Pa_t_1 to Ma_1');
grid on;
