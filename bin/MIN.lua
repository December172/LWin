LuaQ    @A/CHDK/LUALIB/MinLWin.lua           
p   
@  	À   À  A    EÀ  @ \ \ @  ÀAä            @\ 	A  dA     	A  J Á Á B A bA 	A  JÁ IÄIADIÄIÁDIAEIÁEIAF	A  d     	A  dÁ     	A  d    	A  dA    	A
  A A  ÁAÅ  $         ÉÅ  $Â    ÉÅ  $    ÉÅ  $B    ÉÅ  $          ÉÅ  $Â       ÉÅ  $          ÉäA    	Áä    	ÁÅ  $Â ÉÅ  $ ÉÅ  Þ   *      LWin    Version    1.0.1 Debug    loadstring ó  local Stack = {}
		Stack.__index = Stack
		function Stack:new()
    			local temp = {_Stack = {__mode = "kv"} }
    			setmetatable(temp,self)
    			return temp
		end
		function Stack:Pop()
    			if #(self._Stack) == 0 then
        				error("Stack is empty.",2)
    			end
    			return table.remove(self._Stack,#self._Stack)
		end
		function Stack:Push(t)
   			table.insert(self._Stack,t)
		end
		function Stack:Count()
    			return #self._Stack
		end

		function Stack:IsEmpty()
   			if self:Count() == 0 then
        				return true
    			else
        				return false
   		 	end
		end
		function Stack:Top()
			if #(self._Stack)==0 then
      				error("Stack is empty.",2)
   			end
   			return self._Stack[#self._Stack]
		end
		return Stack ×  local draw = { Version = "1.1"}
		    local SCREEN_DRAWINGS={__mode = "kv"}
		    function draw:Add( d_type, p1, p2, p3, p4, p5, p6, p7 )
    		    	local n = #SCREEN_DRAWINGS + 1
		    	if d_type=="pixel" then
        				SCREEN_DRAWINGS[n]={"p",p1,p2,p3}--x,y,cl
        				return n
    			elseif d_type=="line" then
        				SCREEN_DRAWINGS[n]={"l",p1,p2,p3,p4,p5}--x1,y1,x2,y2,cl
        				return n
    			elseif d_type=="rect" then
        				SCREEN_DRAWINGS[n]={"r",p1,p2,p3,p4,p5,p6}--x1,y1,x2,y2,cl,th
        				return n
    			elseif d_type=="rectf" then
        				SCREEN_DRAWINGS[n]={"rf",p1,p2,p3,p4,p5,p6,p7}--x1,y1,x2,y2,clf,clb,th
        				return n
    			elseif d_type=="elps" then
        				SCREEN_DRAWINGS[n]={"e",p1,p2,p3,p4,p5}--x,y,a,b,cl
       				return n
    			elseif d_type=="elpsf" then
        				SCREEN_DRAWINGS[n]={"ef",p1,p2,p3,p4,p5}--x,y,a,b,clf
        				return n
    			elseif d_type=="string" then
        				SCREEN_DRAWINGS[n]={"s",p1,p2,p3,p4,p5,p6,p7} --x,y,string,foreg_cl,backgr_cl,fontsizeX,fontsizeY
        				return n
    			end
    		    return false
		end
        function draw:Replace( n, d_type, p1, p2, p3, p4, p5, p6, p7 )
            self:Remove(n)
            if d_type=="pixel" then
                SCREEN_DRAWINGS[n]={"p",p1,p2,p3}--x,y,cl
                return n
            elseif d_type=="line" then
                SCREEN_DRAWINGS[n]={"l",p1,p2,p3,p4,p5}--x1,y1,x2,y2,cl
                return n
            elseif d_type=="rect" then
                SCREEN_DRAWINGS[n]={"r",p1,p2,p3,p4,p5,p6}--x1,y1,x2,y2,cl,th
                return n
            elseif d_type=="rectf" then
                SCREEN_DRAWINGS[n]={"rf",p1,p2,p3,p4,p5,p6,p7}--x1,y1,x2,y2,clf,clb,th
                return n
            elseif d_type=="elps" then
                SCREEN_DRAWINGS[n]={"e",p1,p2,p3,p4,p5}--x,y,a,b,cl
                return n
            elseif d_type=="elpsf" then
                SCREEN_DRAWINGS[n]={"ef",p1,p2,p3,p4,p5}--x,y,a,b,cl
                return n
            elseif d_type=="string" then
                SCREEN_DRAWINGS[n]={"s",p1,p2,p3,p4,p5,p6,p7}--x,y,string,foreg_cl,backgr_cl,fontsizeX,fontsizeY
                return n
            end
            return false
        end
--[
    function draw:GetParam(n)
        local out={nil}
        if SCREEN_DRAWINGS[n][1] == "p" then out[1]="pixel"
        elseif SCREEN_DRAWINGS[n][1] == "l" then out[1]="line"
        elseif SCREEN_DRAWINGS[n][1] == "r" then out[1]="rect"
        elseif SCREEN_DRAWINGS[n][1] == "rf" then out[1]="rectf"
        elseif SCREEN_DRAWINGS[n][1] == "e" then out[1]="elps"
        elseif SCREEN_DRAWINGS[n][1] == "ef" then out[1]="elpsf"
        elseif SCREEN_DRAWINGS[n][1] == "s" then out[1]="string"
        end
        if (out[1]~=nil) then
            for i=2, table.getn(SCREEN_DRAWINGS[n]) do
                out[i]=SCREEN_DRAWINGS[n][i]
            end
        end
        return out
    end
--]
    function draw:Overdraw()
        for i=1,table.getn(SCREEN_DRAWINGS) do
            local d_type=SCREEN_DRAWINGS[i][1]
            if d_type=="p" then
                local x=SCREEN_DRAWINGS[i][2]
                local y=SCREEN_DRAWINGS[i][3]
                local c=SCREEN_DRAWINGS[i][4]
                draw_pixel(x,y,self:MakeColor(c))
            elseif d_type=="l" then
                local x1=SCREEN_DRAWINGS[i][2]
                local y1=SCREEN_DRAWINGS[i][3]
                local x2=SCREEN_DRAWINGS[i][4]
                local y2=SCREEN_DRAWINGS[i][5]
                local c=SCREEN_DRAWINGS[i][6]
                draw_line(x1,y1,x2,y2,self:MakeColor(c))
            elseif d_type=="r" then
                local x1=SCREEN_DRAWINGS[i][2]
                local y1=SCREEN_DRAWINGS[i][3]
                local x2=SCREEN_DRAWINGS[i][4]
                local y2=SCREEN_DRAWINGS[i][5]
                local c=SCREEN_DRAWINGS[i][6]
                local t=SCREEN_DRAWINGS[i][7]
                draw_rect(x1,y1,x2,y2,self:MakeColor(c),t)
            elseif d_type=="rf" then
                local x1=SCREEN_DRAWINGS[i][2]
                local y1=SCREEN_DRAWINGS[i][3]
                local x2=SCREEN_DRAWINGS[i][4]
                local y2=SCREEN_DRAWINGS[i][5]
                local cf=SCREEN_DRAWINGS[i][6]
                local cb=SCREEN_DRAWINGS[i][7]
                local t=SCREEN_DRAWINGS[i][8]
                draw_rect_filled(x1,y1,x2,y2,self:MakeColor(cf),self:MakeColor(cb),t)
            elseif d_type=="e" then
                local x=SCREEN_DRAWINGS[i][2]
                local y=SCREEN_DRAWINGS[i][3]
                local a=SCREEN_DRAWINGS[i][4]
                local b=SCREEN_DRAWINGS[i][5]
                local c=SCREEN_DRAWINGS[i][6]
                draw_ellipse(x,y,a,b,self:MakeColor(c))
            elseif d_type=="ef" then
                local x=SCREEN_DRAWINGS[i][2]
                local y=SCREEN_DRAWINGS[i][3]
                local a=SCREEN_DRAWINGS[i][4]
                local b=SCREEN_DRAWINGS[i][5]
                local c=SCREEN_DRAWINGS[i][6]
                draw_ellipse_filled(x,y,a,b,self:MakeColor(c))
            elseif d_type=="s" then
                local x=SCREEN_DRAWINGS[i][2]
                local y=SCREEN_DRAWINGS[i][3]
                local s=SCREEN_DRAWINGS[i][4]
                local cf=SCREEN_DRAWINGS[i][5]
                local cb=SCREEN_DRAWINGS[i][6]
                local fontx=SCREEN_DRAWINGS[i][7]
                local fonty=SCREEN_DRAWINGS[i][8]
                if fontx then
                    draw_string(x,y,s,self:MakeColor(cf),self:MakeColor(cb)) -- faster if no scaling
                else
                    draw_string(x,y,s,self:MakeColor(cf),self:MakeColor(cb),fontx,fonty)
                end
            end
        end
    end
    function draw:Redraw()
        draw_clear()  --note: it's not "draw.clear()" from this module but "draw_clear()" - a lua command!
        self:Overdraw()
    end
    function draw:MakeColor(c)
        --note - c variable changes type if it's a correct string!
        if (c=="trans")         then c=255+1 end
        if (c=="black")         then c=255+2 end
        if (c=="white")         then c=255+3 end
        if (c=="red")           then c=255+4 end
        if (c=="red_dark")      then c=255+5 end
        if (c=="red_light")     then c=255+6 end
        if (c=="green")         then c=255+7 end
        if (c=="green_dark")    then c=255+8 end
        if (c=="green_light")   then c=255+9 end
        if (c=="blue")          then c=255+10 end
        if (c=="blue_dark")     then c=255+11 end
        if (c=="blue_light")    then c=255+12 end
        if (c=="grey")          then c=255+13 end
        if (c=="grey_dark")     then c=255+14 end
        if (c=="grey_light")    then c=255+15 end
        if (c=="yellow")        then c=255+16 end
        if (c=="yellow_dark")   then c=255+17 end
        if (c=="yellow_light")  then c=255+18 end
        if (c=="grey_trans")    then c=255+19 end
        return c
    end
    function draw:Remove(n)
        if (n<=table.getn(SCREEN_DRAWINGS)) then
            for i=1,table.getn(SCREEN_DRAWINGS[n]) do
                SCREEN_DRAWINGS[n][i]=nil
            end
        end
    end
    function draw:Clear()
        for i=1, table.getn(SCREEN_DRAWINGS) do
            self:Remove(i)
        end
        draw_clear()
    end
    return draw
    __mode    kv    CreateInstance    GetInstance    KEYS_TABLE    set 	   playback    video    menu    DefinedMsg    WM_KEY_SET    WM_KEY_PLAYBACK    WM_KEY_VIDEO    WM_KEY_MENU    paint 	   WM_PAINT    destory    WM_DESTORY    quit    WM_QUIT    GetMsg    DispatchMsg    RemoveTopMsg    PostMsg        CreateHWnd    RegisterWnd    GetWnd    GetHWnd 
   CreateWnd    ShowWnd 
   UnloadWnd    TextOut    RemoveElement    LoadApp    GC        Ú   é           d            ^                  Ü   è    2       @     Ä   
   @  À   Å   D  B@ ÜA ¡  ýÀ  Æ Á  @A  Á A@  Ä   À Ä  Ë ÂÜ À  Ä   À Ä  Ë ÂÜ À  Ä   À Ä   À                 pairs    rawset    type    Type    string    Win 	   WndStack    new 	   MsgStack 
   HInstance     2   Ý   Ý   Ý   Þ   Þ   Þ   Þ   ß   ß   ß   ß   à   à   à   à   à   à   à   ß   à   â   â   â   â   â   â   â   â   ã   ã   ã   ã   ã   ã   ã   ä   ä   ä   ä   ä   ä   ä   æ   æ   æ   æ   æ   ç   ç   è         self     1   
   MainClass     1      (for generator) 
         (for state) 
         (for control) 
         k          v             InstanceCounter    InstanceTable    Stack    Û   è   è   è   è   è   é         InstanceCounter             InstanceTable    Stack     í   ï          @                î   î   î   ï         self        
   hInstance              InstanceTable     ü      
1      @  @@@ @  À   @  @@ ÆÀ@ Æ ÁÀ À À@  A  @    @ ÆA Ô A   Á ÆA ÆA     A @BÂ@ FA FBBA  @û       	   	   MsgStack    IsEmpty    Top    DefinedMsg    quit       KEYS_TABLE    is_key    Push     1   ý   ý   ý   ý   ý   ý   ý   þ   þ   þ   þ   þ   þ   þ   þ   þ   ÿ   ÿ   ÿ   ÿ                                                                   self     0   
   hInstance     0      (for index)    .      (for limit)    .      (for step)    .      i    -         InstanceTable           E      @  @@@ @À@Ä   Æ@@   Ä   Æ@Æ@ÁËÁÜ Ú@  @Ä   Æ@Æ@ÁË@ÀÜ ÁA B @   @Ä   Æ@Æ@ÁË@ÀÜ ÁA AB   @ Ä   Æ@Æ@ÁËÂÜ@ Ä   Æ@Æ@ÁËÁÜ Ú   Àõ BËÀB @ ÁA BÝ  Þ   À@B@ËÀB @ ÁA ABÝ  Þ        	   WndStack    Top 	   WndClass 
   _Callback     	   MsgStack    IsEmpty    DefinedMsg    quit    destory    Pop    PostMsg     E                                                                                                                                                    self     D   
   hInstance     D      status    D         InstanceTable     "  $         @  @@@          	   MsgStack    Pop        #  #  #  #  #  #  $        self        
   hInstance              InstanceTable     &  (      Ä   Æ@Æ ÀË@À@ Ý Þ        	   MsgStack    Push        '  '  '  '  '  '  '  (        self        
   hInstance           Msg              InstanceTable     /  I   (   D   L À H   J    À@À@Á ÂÂ ÃÃ ÄI@  ÀDI¤   I  Â   IÀ À  
  dA  	AD 	A@  Ä   @  Ä   À              	   WndClass    x 2      y    len       wid d      cf    blue    cb    white    border       sytle        DC    __mode    kv 
   _Callback    Proxy 	   newproxy    setmetatable    __gc    __index    Wnd        <  <                    <        self                 @  B           A@  @         print    gc        A  A  A  B          (   0  0  0  1  2  2  3  4  5  6  7  8  9  :  ;  ;  ;  <  <  =  =  =  =  ?  ?  ?  B  B  C  C  ?  F  F  F  G  G  G  H  H  I        self     '      Wnd    '         WndCounter    WindowFunc 	   WndTable     K  M      Ä   Æ@Æ ÀÉ     	   WndClass 
   _Callback        L  L  L  L  M        self           hWnd        	   Callback           	   WndTable     O  Q         @                P  P  P  Q        self           hWnd           	   WndTable     S  U          @          Wnd        T  T  T  U        self           Wnd           	   WndTable     W  ^   K   Ä   Æ@ÀD KÀÁÁ   EB ÁÂA\   E B ÆÁÆÂ \   ÅB ÁCBFÁFÃÁCÜ   Å C FÁFÂÁBL Ü   EÃ ÁC\   E Ã ÆÁÆCÃ \   ÅC ÁCÜ   \  	A  ÁC     ÁCDAAD  Á   Õ           DC       Add    rectf    assert 	   tonumber 	   WndClass    x    y    len    wid 	   tostring    cf    cb    border 	   WndStack    Push    PostMsg    WM_CREATE_     K   X  X  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Z  Z  Z  Z  Z  [  [  [  [  [  [  \  \  \  \  \  \  \  ^        self     J      hWnd     J   
   hInstance     J      Wnd    J      	   WndTable    draw    InstanceTable     `  y         @           "   Å   ÆÀÆÀÀÀÅ   ÆÀÆ@ÁÀ Å   ÆÀÆÀÁÀ Å   ÆÀÆ@ÂÀ Å   ÆÀÆÀÂÀ Å   ÆÀÆ@ÃÀ Å   ÆÀÆÀÃÀ Å   Æ Ä AD  DA@Á Â E B@\   EÂ  ÆA \  Â Å AFC@CÜ   ÅÂ  FBAL Ü  Ã EC B\   EÃ C ÆC \  Ã Å CÜ     É Å   Æ ÄÆ ÁÚ   @Á    D AA  àÅ   DÜ ÀÅ@ À	@	Å  ÆÄÆÆÆ@ÆÀÅ  ËÆE  FÄFFÂÀ  DBAÅ  ÆÄÆÆÂÆ  DÃBE  FÄFFCÃ  DGÅ  ÆÄÆÆCÇ  ÜA ßÀó  G             Wnd    	   WndClass    x       y       len       wid       cf       cb       border    DC    Replace    rectf    assert 	   tonumber 	   tostring    type    nil    _lable    string    TextOut    text    scalex    scaley    Redraw        a  a  a  b  b  b  c  d  d  d  d  e  e  e  e  f  f  f  f  g  g  g  g  h  h  h  h  i  i  i  i  j  j  j  j  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  k  l  l  l  l  l  m  m  m  m  m  m  n  n  n  n  n  n  n  o  o  q  q  q  q  q  q  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  r  m  x  x  x  x  y        self           hWnd           Array          (for index) ^         (for limit) ^         (for step) ^         i _         	   WndTable    draw     {     '   Ä   Æ@  FAÀT   Á  FBÀFÂ À@@ ABÀÂBÀ  FBÀFÂ @A@ ABÀÂABù  ÁAB     	         DC    type    number    Remove    table    id 	   WndStack    Pop     '   |  |  }  }  }  }  }  ~  ~  ~  ~  ~  ~                                      }                      self     &      hWnd     &   
   hInstance     &      Wnd    &      (for index)           (for limit)           (for step)           i          	   WndTable    draw    InstanceTable         	 ,   F@ B  @ B@B Â@BAÆÂA ÆÂÌÂ ÂÆÂA ÆÂÌÂÂÂBÂIÄ  ËÃAÃ AÆÆCÂDAFFÂÄB	ÆÆÃ	EC
Ü Â         DC       id        _lable    text    x 	   WndClass    border    y    cf    cb    scalex    scaley    Add    string     ,                                                                                           
      self     +      x     +      y     +      Text     +      FrontColor     +   
   BackColor     +      Scalex     +      Scaley     +      place     +      _DC    +         draw       ¤   	       @A@ A @@@@     @@ ÀÀ   Æ@@ Ô    A@ ÆA@ Á ÆÁ @þ        Remove    DC    id                                                     ¡  ¡  ¡  ¡  ¡     ¤        self        	   hElement           (for index)          (for limit)          (for step)          i             draw     ¨  ´    	>   Å   A  @  W@  A   AÁ  Ü@Å    Ü A  @ W@A  A@ W@ @     ÁA@ Á ÁÁA  À    ÁA@Á ÁA  À    ÁA@ ÁA  T A À  T FAI           assert    type    string    Not a vaild path!    file_browser    nil    match    gsub    /           .LUA    .lua    require    LWinLib     >   ©  ©  ©  ©  ©  ©  ©  ©  ©  ©  ª  ª  ª  «  «  «  «  «  «  «  «  «  «  «  «  ¬  ¬  ®  ®  ®  ®  ®  ®  ®  ®  ®  ®  ¯  ¯  ¯  ¯  ¯  ¯  ¯  ¯  °  °  °  °  °  °  °  ±  ±  ±  ±  ±  ²  ²  ²  ³  ´        self     =      Path     =      AppList     =      AppPath    =      AppName 4   =           ¶  ¹       E   @  \@ E     ]  ^           collectgarbage    collect    count        ·  ·  ·  ¸  ¸  ¸  ¸  ¹        self            p               %      %   &   Ö   &   Ö   Ù   Ù   é   é   é   ë   ë   ë   ë   í   ï   ï   í   ò   ò   ò   ò   ò   ò   ò   ò   ó   ó   ó   ô   õ   ö   ÷   ø   ù   ú   ü       ü             "  $  $  "  &  (  (  &  +  ,  -  -  /  I  I  I  I  /  K  M  M  K  O  Q  Q  O  S  U  U  S  W  ^  ^  ^  ^  W  `  y  y  y  `  {          {        ¤  ¤    ¨  ´  ¨  ¶  ¹  ¶  »  »  »        Stack    o      draw    o      InstanceTable    o      _CreateInstance    o      WindowFunc ;   o      WndCounter <   o   	   WndTable >   o       