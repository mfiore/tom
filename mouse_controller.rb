class MouseController
##
# Returns an array [x,y] containing the mouse coordinates
# Be are that the coordinate system is OS dependent.
  
  def initialize()
    @get_cursor_pos = Win32API.new("user32", "GetCursorPos", 'P', 'L')
    @key_state = Win32API.new('user32', 'GetAsyncKeyState', 'i', 'i')
    @screen_to_client = Win32API.new('user32', 'ScreenToClient', %w(l p), 'i') 
    @find_window = Win32API.new('user32', 'FindWindowA', %w(p p), 'l')
    @read_ini = Win32API.new('kernel32', 'GetPrivateProfileStringA', %w(p p p p l p), 'l')
  end
  def getMouseLocation
    # point is a Long,Long-struct
    point = "\0" * 8
    if @get_cursor_pos.call(point)
  #    point.unpack('LL')
      screenToClient(point)
    else
      [nil,nil]
    end
  end
  def processedTrigger
    #@timer=nil
  end
  def getKeyPressed
    left=@key_state.call(0x01)!=0
    right=@key_state.call(0x02)!=0
    left=buttonThreshold(left,"left")
    right=buttonThreshold(right,"right")

    [left,right]
  end

  def buttonThreshold(button,button_name)
    if button==true  #double click
      if timerStarted?(button_name)
        button=false
        timer2=Time.now
        if timer2-getTime(button_name)>0.5
          stopTimer(button_name)
        end
      else
        startTimer(button_name)
      end
    end
    button
  end
  def timerStarted?(button_name)
    if button_name=="left"
      return @timer_left!=nil
    else
      return @timer_right!=nil
    end
  end
  def startTimer(button_name)
    if button_name=="left"
      @timer_left=Time.now
    else
      @timer_right=Time.now
    end
  end
  def stopTimer(button_name)
    if button_name=="left"
      @timer_left=nil
    else
      @timer_right=nil
    end
  end
  def getTime(button_name)
    if button_name=="left"
      return @timer_left
    else
      return @timer_right
    end
  end
  def screenToClient(pos)
    #pos = [x, y].pack('ll')
    return @screen_to_client.call(getWindowHandle, pos) == 0 ? nil : pos.unpack('ll')
  end
  def getWindowHandle
    if @window_handle.nil?
      title = "\0" * 256
      @read_ini.call('Game', 'Title', '', title, 255, '.\\Game.ini')
      title.delete!("\0")
      @window_handle = @find_window.call('RGSS Player', title) 
      #ShowCursor.call(0)
    end
    return @window_handle
  end
  def mouseToMapCoordinates
    if isInBoundary?
      pos=getMouseLocation
      map_x=(pos[0]/32).floor+$game_map.display_x
      map_y=(pos[1]/32).floor+$game_map.display_y
      [map_x,map_y]
    else [nil,nil]
    end
  end
  def isInBoundary?
    pos=getMouseLocation
    pos[0]>=0 and pos[0]<Graphics.width and pos[1]>=0 and pos[1]<Graphics.height
  end


end