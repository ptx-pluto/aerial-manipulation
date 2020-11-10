classdef PPROutputData < ros.Message
    %PPROutputData MATLAB implementation of quadrotor_msgs/PPROutputData
    %   This class was automatically generated by
    %   ros.msg.internal.gen.MessageClassGenerator.
    
    %   Copyright 2014-2020 The MathWorks, Inc.
    
    %#ok<*INUSD>
    
    properties (Constant)
        MessageType = 'quadrotor_msgs/PPROutputData' % The ROS message type
    end
    
    properties (Constant, Hidden)
        MD5Checksum = '732c0e3ca36f241464f8c445e78a0d0a' % The MD5 Checksum of the message definition
    end
    
    properties (Access = protected)
        JavaMessage % The Java message object
    end
    
    properties (Constant, Access = protected)
        StdMsgsHeaderClass = ros.msg.internal.MessageFactory.getClassForType('std_msgs/Header') % Dispatch to MATLAB class for message type std_msgs/Header
    end
    
    properties (Dependent)
        Header
        QuadTime
        DesThrust
        DesRoll
        DesPitch
        DesYaw
        EstRoll
        EstPitch
        EstYaw
        EstAngvelX
        EstAngvelY
        EstAngvelZ
        EstAccX
        EstAccY
        EstAccZ
        Pwm
    end
    
    properties (Access = protected)
        Cache = struct('Header', []) % The cache for fast data access
    end
    
    properties (Constant, Hidden)
        PropertyList = {'DesPitch', 'DesRoll', 'DesThrust', 'DesYaw', 'EstAccX', 'EstAccY', 'EstAccZ', 'EstAngvelX', 'EstAngvelY', 'EstAngvelZ', 'EstPitch', 'EstRoll', 'EstYaw', 'Header', 'Pwm', 'QuadTime'} % List of non-constant message properties
        ROSPropertyList = {'des_pitch', 'des_roll', 'des_thrust', 'des_yaw', 'est_acc_x', 'est_acc_y', 'est_acc_z', 'est_angvel_x', 'est_angvel_y', 'est_angvel_z', 'est_pitch', 'est_roll', 'est_yaw', 'header', 'pwm', 'quad_time'} % List of non-constant ROS message properties
    end
    
    methods
        function obj = PPROutputData(msg)
            %PPROutputData Construct the message object PPROutputData
            import com.mathworks.toolbox.ros.message.MessageInfo;
            
            % Support default constructor
            if nargin == 0
                obj.JavaMessage = obj.createNewJavaMessage;
                return;
            end
            
            % Construct appropriate empty array
            if isempty(msg)
                obj = obj.empty(0,1);
                return;
            end
            
            % Make scalar construction fast
            if isscalar(msg)
                % Check for correct input class
                if ~MessageInfo.compareTypes(msg(1), obj.MessageType)
                    error(message('ros:mlros:message:NoTypeMatch', obj.MessageType, ...
                        char(MessageInfo.getType(msg(1))) ));
                end
                obj.JavaMessage = msg(1);
                return;
            end
            
            % Check that this is a vector of scalar messages. Since this
            % is an object array, use arrayfun to verify.
            if ~all(arrayfun(@isscalar, msg))
                error(message('ros:mlros:message:MessageArraySizeError'));
            end
            
            % Check that all messages in the array have the correct type
            if ~all(arrayfun(@(x) MessageInfo.compareTypes(x, obj.MessageType), msg))
                error(message('ros:mlros:message:NoTypeMatchArray', obj.MessageType));
            end
            
            % Construct array of objects if necessary
            objType = class(obj);
            for i = 1:length(msg)
                obj(i,1) = feval(objType, msg(i)); %#ok<AGROW>
            end
        end
        
        function header = get.Header(obj)
            %get.Header Get the value for property Header
            if isempty(obj.Cache.Header)
                obj.Cache.Header = feval(obj.StdMsgsHeaderClass, obj.JavaMessage.getHeader);
            end
            header = obj.Cache.Header;
        end
        
        function set.Header(obj, header)
            %set.Header Set the value for property Header
            validateattributes(header, {obj.StdMsgsHeaderClass}, {'nonempty', 'scalar'}, 'PPROutputData', 'Header');
            
            obj.JavaMessage.setHeader(header.getJavaObject);
            
            % Update cache if necessary
            if ~isempty(obj.Cache.Header)
                obj.Cache.Header.setJavaObject(header.getJavaObject);
            end
        end
        
        function quadtime = get.QuadTime(obj)
            %get.QuadTime Get the value for property QuadTime
            quadtime = typecast(int16(obj.JavaMessage.getQuadTime), 'uint16');
        end
        
        function set.QuadTime(obj, quadtime)
            %set.QuadTime Set the value for property QuadTime
            validateattributes(quadtime, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'QuadTime');
            
            obj.JavaMessage.setQuadTime(quadtime);
        end
        
        function desthrust = get.DesThrust(obj)
            %get.DesThrust Get the value for property DesThrust
            desthrust = double(obj.JavaMessage.getDesThrust);
        end
        
        function set.DesThrust(obj, desthrust)
            %set.DesThrust Set the value for property DesThrust
            validateattributes(desthrust, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'DesThrust');
            
            obj.JavaMessage.setDesThrust(desthrust);
        end
        
        function desroll = get.DesRoll(obj)
            %get.DesRoll Get the value for property DesRoll
            desroll = double(obj.JavaMessage.getDesRoll);
        end
        
        function set.DesRoll(obj, desroll)
            %set.DesRoll Set the value for property DesRoll
            validateattributes(desroll, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'DesRoll');
            
            obj.JavaMessage.setDesRoll(desroll);
        end
        
        function despitch = get.DesPitch(obj)
            %get.DesPitch Get the value for property DesPitch
            despitch = double(obj.JavaMessage.getDesPitch);
        end
        
        function set.DesPitch(obj, despitch)
            %set.DesPitch Set the value for property DesPitch
            validateattributes(despitch, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'DesPitch');
            
            obj.JavaMessage.setDesPitch(despitch);
        end
        
        function desyaw = get.DesYaw(obj)
            %get.DesYaw Get the value for property DesYaw
            desyaw = double(obj.JavaMessage.getDesYaw);
        end
        
        function set.DesYaw(obj, desyaw)
            %set.DesYaw Set the value for property DesYaw
            validateattributes(desyaw, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'DesYaw');
            
            obj.JavaMessage.setDesYaw(desyaw);
        end
        
        function estroll = get.EstRoll(obj)
            %get.EstRoll Get the value for property EstRoll
            estroll = double(obj.JavaMessage.getEstRoll);
        end
        
        function set.EstRoll(obj, estroll)
            %set.EstRoll Set the value for property EstRoll
            validateattributes(estroll, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstRoll');
            
            obj.JavaMessage.setEstRoll(estroll);
        end
        
        function estpitch = get.EstPitch(obj)
            %get.EstPitch Get the value for property EstPitch
            estpitch = double(obj.JavaMessage.getEstPitch);
        end
        
        function set.EstPitch(obj, estpitch)
            %set.EstPitch Set the value for property EstPitch
            validateattributes(estpitch, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstPitch');
            
            obj.JavaMessage.setEstPitch(estpitch);
        end
        
        function estyaw = get.EstYaw(obj)
            %get.EstYaw Get the value for property EstYaw
            estyaw = double(obj.JavaMessage.getEstYaw);
        end
        
        function set.EstYaw(obj, estyaw)
            %set.EstYaw Set the value for property EstYaw
            validateattributes(estyaw, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstYaw');
            
            obj.JavaMessage.setEstYaw(estyaw);
        end
        
        function estangvelx = get.EstAngvelX(obj)
            %get.EstAngvelX Get the value for property EstAngvelX
            estangvelx = double(obj.JavaMessage.getEstAngvelX);
        end
        
        function set.EstAngvelX(obj, estangvelx)
            %set.EstAngvelX Set the value for property EstAngvelX
            validateattributes(estangvelx, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstAngvelX');
            
            obj.JavaMessage.setEstAngvelX(estangvelx);
        end
        
        function estangvely = get.EstAngvelY(obj)
            %get.EstAngvelY Get the value for property EstAngvelY
            estangvely = double(obj.JavaMessage.getEstAngvelY);
        end
        
        function set.EstAngvelY(obj, estangvely)
            %set.EstAngvelY Set the value for property EstAngvelY
            validateattributes(estangvely, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstAngvelY');
            
            obj.JavaMessage.setEstAngvelY(estangvely);
        end
        
        function estangvelz = get.EstAngvelZ(obj)
            %get.EstAngvelZ Get the value for property EstAngvelZ
            estangvelz = double(obj.JavaMessage.getEstAngvelZ);
        end
        
        function set.EstAngvelZ(obj, estangvelz)
            %set.EstAngvelZ Set the value for property EstAngvelZ
            validateattributes(estangvelz, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstAngvelZ');
            
            obj.JavaMessage.setEstAngvelZ(estangvelz);
        end
        
        function estaccx = get.EstAccX(obj)
            %get.EstAccX Get the value for property EstAccX
            estaccx = double(obj.JavaMessage.getEstAccX);
        end
        
        function set.EstAccX(obj, estaccx)
            %set.EstAccX Set the value for property EstAccX
            validateattributes(estaccx, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstAccX');
            
            obj.JavaMessage.setEstAccX(estaccx);
        end
        
        function estaccy = get.EstAccY(obj)
            %get.EstAccY Get the value for property EstAccY
            estaccy = double(obj.JavaMessage.getEstAccY);
        end
        
        function set.EstAccY(obj, estaccy)
            %set.EstAccY Set the value for property EstAccY
            validateattributes(estaccy, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstAccY');
            
            obj.JavaMessage.setEstAccY(estaccy);
        end
        
        function estaccz = get.EstAccZ(obj)
            %get.EstAccZ Get the value for property EstAccZ
            estaccz = double(obj.JavaMessage.getEstAccZ);
        end
        
        function set.EstAccZ(obj, estaccz)
            %set.EstAccZ Set the value for property EstAccZ
            validateattributes(estaccz, {'numeric'}, {'nonempty', 'scalar'}, 'PPROutputData', 'EstAccZ');
            
            obj.JavaMessage.setEstAccZ(estaccz);
        end
        
        function pwm = get.Pwm(obj)
            %get.Pwm Get the value for property Pwm
            javaArray = obj.JavaMessage.getPwm;
            array = obj.readJavaArray(javaArray, 'uint16');
            pwm = uint16(array);
        end
        
        function set.Pwm(obj, pwm)
            %set.Pwm Set the value for property Pwm
            validateattributes(pwm, {'numeric'}, {'vector', 'numel', 4}, 'PPROutputData', 'Pwm');
            
            javaArray = obj.JavaMessage.getPwm;
            array = obj.writeJavaArray(pwm, javaArray, 'uint16');
            obj.JavaMessage.setPwm(array);
        end
    end
    
    methods (Access = protected)
        function resetCache(obj)
            %resetCache Resets any cached properties
            obj.Cache.Header = [];
        end
        
        function cpObj = copyElement(obj)
            %copyElement Implements deep copy behavior for message
            
            % Call default copy method for shallow copy
            cpObj = copyElement@ros.Message(obj);
            
            % Clear any existing cached properties
            cpObj.resetCache;
            
            % Create a new Java message object
            cpObj.JavaMessage = obj.createNewJavaMessage;
            
            % Iterate over all primitive properties
            cpObj.QuadTime = obj.QuadTime;
            cpObj.DesThrust = obj.DesThrust;
            cpObj.DesRoll = obj.DesRoll;
            cpObj.DesPitch = obj.DesPitch;
            cpObj.DesYaw = obj.DesYaw;
            cpObj.EstRoll = obj.EstRoll;
            cpObj.EstPitch = obj.EstPitch;
            cpObj.EstYaw = obj.EstYaw;
            cpObj.EstAngvelX = obj.EstAngvelX;
            cpObj.EstAngvelY = obj.EstAngvelY;
            cpObj.EstAngvelZ = obj.EstAngvelZ;
            cpObj.EstAccX = obj.EstAccX;
            cpObj.EstAccY = obj.EstAccY;
            cpObj.EstAccZ = obj.EstAccZ;
            cpObj.Pwm = obj.Pwm;
            
            % Recursively copy compound properties
            cpObj.Header = copy(obj.Header);
        end
        
        function reload(obj, strObj)
            %reload Called by loadobj to assign properties
            obj.QuadTime = strObj.QuadTime;
            obj.DesThrust = strObj.DesThrust;
            obj.DesRoll = strObj.DesRoll;
            obj.DesPitch = strObj.DesPitch;
            obj.DesYaw = strObj.DesYaw;
            obj.EstRoll = strObj.EstRoll;
            obj.EstPitch = strObj.EstPitch;
            obj.EstYaw = strObj.EstYaw;
            obj.EstAngvelX = strObj.EstAngvelX;
            obj.EstAngvelY = strObj.EstAngvelY;
            obj.EstAngvelZ = strObj.EstAngvelZ;
            obj.EstAccX = strObj.EstAccX;
            obj.EstAccY = strObj.EstAccY;
            obj.EstAccZ = strObj.EstAccZ;
            obj.Pwm = strObj.Pwm;
            obj.Header = feval([obj.StdMsgsHeaderClass '.loadobj'], strObj.Header);
        end
    end
    
    methods (Access = ?ros.Message)
        function strObj = saveobj(obj)
            %saveobj Implements saving of message to MAT file
            
            % Return an empty element if object array is empty
            if isempty(obj)
                strObj = struct.empty;
                return
            end
            
            strObj.QuadTime = obj.QuadTime;
            strObj.DesThrust = obj.DesThrust;
            strObj.DesRoll = obj.DesRoll;
            strObj.DesPitch = obj.DesPitch;
            strObj.DesYaw = obj.DesYaw;
            strObj.EstRoll = obj.EstRoll;
            strObj.EstPitch = obj.EstPitch;
            strObj.EstYaw = obj.EstYaw;
            strObj.EstAngvelX = obj.EstAngvelX;
            strObj.EstAngvelY = obj.EstAngvelY;
            strObj.EstAngvelZ = obj.EstAngvelZ;
            strObj.EstAccX = obj.EstAccX;
            strObj.EstAccY = obj.EstAccY;
            strObj.EstAccZ = obj.EstAccZ;
            strObj.Pwm = obj.Pwm;
            strObj.Header = saveobj(obj.Header);
        end
    end
    
    methods (Static, Access = {?matlab.unittest.TestCase, ?ros.Message})
        function obj = loadobj(strObj)
            %loadobj Implements loading of message from MAT file
            
            % Return an empty object array if the structure element is not defined
            if isempty(strObj)
                obj = ros.custom.msggen.quadrotor_msgs.PPROutputData.empty(0,1);
                return
            end
            
            % Create an empty message object
            obj = ros.custom.msggen.quadrotor_msgs.PPROutputData;
            obj.reload(strObj);
        end
    end
end
