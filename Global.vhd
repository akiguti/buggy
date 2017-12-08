----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:03:07 12/08/2017 
-- Design Name: 
-- Module Name:    Global - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Global is
    port (
	     clk         : in std_logic;
     	  reset       : in std_logic;
    	  botonU      : in std_logic;
	     botonD      : in std_logic;
   	  ledSelector : out std_logic_vector(3 downto 0);
		  led7seg     : out std_logic_vector(6 downto 0)
		  
	 
	 );

end Global;

architecture Behavioral of Global is

    component Antirrebotes is
        port (
	          clk:     in std_logic;
			    reset:   in std_logic;
			    entrada: in std_logic;
			    salida:  out std_logic
	     );
    end component;
	 
	 signal U: std_logic;
	 signal D: std_logic;
	 
	 -- Aqui iria la declaracion de los estados


begin

    filtro_U : Antirrebotes
	 port map (
	     clk        => clk,
		  reset      => reset,
		  entrada    => botonU,
		  salida     => U
    );
	 
	 filtro_D : Antirrebotes
	 port map (
	     clk        => clk,
		  reset      => reset,
		  entrada    => botonD,
		  salida     => D
    );
	 
	 -- Aqui irian las ecuaciones de estado (manejar cuándo se esta en cada estado)


    -- Funcionamiento del juego:
	 process(clk,reset)
	 begin
	     if reset = '1' then
		      -- Lo que ocurre cuando se le da a reset:
		      -- Aleatorio corre. Posicion del jugador con ello.
		      -- Toda la carretera a 0
				-- Vidas = 3
        elsif clk'event and clk = '1' then
	         if vivo = '0' then
		    		-- Lo que ocurre cuando se esta muerto:
			    	-- KOKE: Corre la aleatoriedad. Posicion del jugador con ello.
				elsif state = S_INI then
				    -- Lo que ocurre cuando se esta en el estado inicial:
					 -- Nada. Displays apagados a la espera de que el jugador le de a reset.
					 -- No hace falta poner las carreteras a 0 (sin coches) porque para
					 --   pasar a jugar pasaremos por el modo reset, donde se ponen ya a 0.
				else
				    -- Lo que ocurre cuando se esta jugando normal:
				    -- Si se pulsa un botón (U/D) -> | YAGO: Cambiar la posición y ver choqueLB (Choque lateral con el borde)
				    --                               | KOKE: Corre la aleatoriedad.
				    --                               |
				    -- Si pasa un ciclo de tiempo (0,8 seg) -> | KOKE: Nuevo traste
				    --                                         | IÑAKI: Todos los demás se desplazan
				    --                                         | JAVI: Ver choqueF
				    --                                         |
				end if;	     
	     end if;
    end process;
	 
	 
	 -- Contador (CNT_0_5) corriendo a 50MHz con rango de 0 a 5

    -- Asignacion de los valores a las salidas:
	 process(clk,reset)
	 begin
	     if reset = '1' then
		      -- Lo que ocurre cuando se le da a reset:
	         -- Todo en negro: led7seg = 0000000 y si no deja ledSelector = 0000 entonces poner cualquiera
        elsif clk'event and clk = '1' then
	         if vivo = '0' then
				    -- Lo que ocurre cuando se esta muerto:
				    -- Explosión: led7seg = 1111111 y ledSelector = 0001
				elsif state = S_INI then
				    -- Lo que ocurre cuando se esta en el estado inicial:
				    -- Todo en negro: led7seg = 0000000 y si no deja ledSelector = 0000 entonces poner cualquiera
				else
    				-- Lo que ocurre cuando se esta jugando normal:
	    			-- switch CNT_0_5 -> | case 0 o 1 (jugador) -> | if posicion = 01 then led7seg = (abajo)
					--                   |                         | if posicion = 10 then led7seg = (medio)
					--                   |                         | if posicion = 11 then led7seg = (arriba)
					--                   |                         | if posicion = 11 (NO DEBERÍA OCURRIR) then suicidate = 1
					--                   | case 2 (traste D)    -> | if D = 00 then led7seg = (nada)
					--                   |                         | if D = 01 then led7seg = (abajo)
					--                   |                         | if D = 10 then led7seg = (medio)
					--                   |                         | if D = 11 then led7seg = (arriba)
					--                   | case 3 (traste C)    -> | if C = 00 then led7seg = (nada)
					--                   |                         | if C = 01 then led7seg = (abajo)
					--                   |                         | if C = 10 then led7seg = (medio)
					--                   |                         | if C = 11 then led7seg = (arriba)
					--                   | case 4 (traste B)    -> | if B = 00 then led7seg = (nada)
					--                   |                         | if B = 01 then led7seg = (abajo)
					--                   |                         | if B = 10 then led7seg = (medio)
					--                   |                         | if B = 11 then led7seg = (arriba)
					--                   | case 5 (traste A)    -> | if A = 00 then led7seg = (nada)
					--                   |                         | if A = 01 then led7seg = abajo)
					--                   |                         | if A = 10 then led7seg = (medio)
					--                   |                         | if A = 11 then led7seg = (arriba)

				end if;	     
	     end if;
    end process;
	 

-- Combinacional: choque = choqueLB + choqueLC + choqueF


end Behavioral;


-- NOTAS:
-- Hay que poner una variable que sea vivo = 1 si estamos en estados vivos, y 0 sino
-- Hay que ver si led7seg y ledSelector funcionan con 1 o con 0

