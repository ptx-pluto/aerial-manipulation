classdef Serial < ros.Message
    %Serial MATLAB implementation of quadrotor_msgs/Serial
    %   This class was automatically generated by
    %   ros.msg.internal.gen.MessageClassGenerator.
    
    %   Copyright 2014-2020 The MathWorks, Inc.
    
    %#ok<*INUSD>
    
    properties (Constant)
        MessageType = 'quadrotor_msgs/Serial' % The ROS message type
    end
    
    properties (Constant, Hidden)
        MD5Checksum = 'e448fb7595af9a8adfcab5ec241c7d4f' % The MD5 Checksum of the message definition
    end
    
    properties (Access = protected)
        JavaMessage % The Java message object
    end
    
    properties (Constant)
        SO3CMD = uint8(115)
        TRPYCMD = uint8(112)
        STATUSDATA = uint8(99)
        OUTPUTDATA = uint8(100)
        PPROUTPUTDATA = uint8(116)
        PPRGAINS = uint8(103)
    end
    
    properties (Constant, Access = protected)
        StdMsgsHeaderClass = ros.msg.internal.MessageFactory.getClassForType('std_msgs/Header') % Dispatch to MATLAB class for message type std_msgs/Header
    end
    
    properties (Dependent)
        Header
        Channel
        Type
        Data
    end
    
    properties (Access = protected)
        Cache = struct('Header', []) % The cache for fast data access
    end
    
    properties (Constant, Hidden)
        PropertyList = {'Channel', 'Data', 'Header', 'Type'} % List of non-constant message properties
        ROSPropertyList = {'channel', 'data', 'header', 'type'} % List of non-constant ROS message properties
    end
    
    methods
        function obj = Serial(msg)
            %Serial Construct the message object Serial
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
            validateattributes(header, {obj.StdMsgsHeaderClass}, {'nonempty', 'scalar'}, 'Serial', 'Header');
            
            obj.JavaMessage.setHeader(header.getJavaObject);
            
            % Update cache if necessary
            if ~isempty(obj.Cache.Header)
                obj.Cache.Header.setJavaObject(header.getJavaObject);
            end
        end
        
        function channel = get.Channel(obj)
            %get.Channel Get the value for property Channel
            channel = typecast(int8(obj.JavaMessage.getChannel), 'uint8');
        end
        
        function set.Channel(obj, channel)
            %set.Channel Set the value for property Channel
            validateattributes(channel, {'numeric'}, {'nonempty', 'scalar'}, 'Serial', 'Channel');
            
            obj.JavaMessage.setChannel(channel);
        end
        
        function type = get.Type(obj)
            %get.Type Get the value for property Type
            type = typecast(int8(obj.JavaMessage.getType), 'uint8');
        end
        
        function set.Type(obj, type)
            %set.Type Set the value for property Type
            validateattributes(type, {'numeric'}, {'nonempty', 'scalar'}, 'Serial', 'Type');
            
            obj.JavaMessage.setType(type);
        end
        
        function data = get.Data(obj)
            %get.Data Get the value for property Data
            javaArray = obj.JavaMessage.getData;
            array = obj.readJavaArray(javaArray, 'uint8');
            data = uint8(array);
        end
        
        function set.Data(obj, data)
            %set.Data Set the value for property Data
            if ~isvector(data) && isempty(data)
                % Allow empty [] input
                data = uint8.empty(0,1);
            end
            
            validateattributes(data, {'numeric'}, {'vector'}, 'Serial', 'Data');
            
            javaArray = obj.JavaMessage.getData;
            array = obj.writeJavaArray(data, javaArray, 'uint8');
            obj.JavaMessage.setData(array);
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
            cpObj.Channel = obj.Channel;
            cpObj.Type = obj.Type;
            cpObj.Data = obj.Data;
            
            % Recursively copy compound properties
            cpObj.Header = copy(obj.Header);
        end
        
        function reload(obj, strObj)
            %reload Called by loadobj to assign properties
            obj.Channel = strObj.Channel;
            obj.Type = strObj.Type;
            obj.Data = strObj.Data;
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
            
            strObj.Channel = obj.Channel;
            strObj.Type = obj.Type;
            strObj.Data = obj.Data;
            strObj.Header = saveobj(obj.Header);
        end
    end
    
    methods (Static, Access = {?matlab.unittest.TestCase, ?ros.Message})
        function obj = loadobj(strObj)
            %loadobj Implements loading of message from MAT file
            
            % Return an empty object array if the structure element is not defined
            if isempty(strObj)
                obj = ros.custom.msggen.quadrotor_msgs.Serial.empty(0,1);
                return
            end
            
            % Create an empty message object
            obj = ros.custom.msggen.quadrotor_msgs.Serial;
            obj.reload(strObj);
        end
    end
end
