classdef Corrections < ros.Message
    %Corrections MATLAB implementation of quadrotor_msgs/Corrections
    %   This class was automatically generated by
    %   ros.msg.internal.gen.MessageClassGenerator.
    
    %   Copyright 2014-2020 The MathWorks, Inc.
    
    %#ok<*INUSD>
    
    properties (Constant)
        MessageType = 'quadrotor_msgs/Corrections' % The ROS message type
    end
    
    properties (Constant, Hidden)
        MD5Checksum = '61e86887a75fe520847d3256306360f5' % The MD5 Checksum of the message definition
    end
    
    properties (Access = protected)
        JavaMessage % The Java message object
    end
    
    properties (Dependent)
        KfCorrection
        AngleCorrections
    end
    
    properties (Constant, Hidden)
        PropertyList = {'AngleCorrections', 'KfCorrection'} % List of non-constant message properties
        ROSPropertyList = {'angle_corrections', 'kf_correction'} % List of non-constant ROS message properties
    end
    
    methods
        function obj = Corrections(msg)
            %Corrections Construct the message object Corrections
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
        
        function kfcorrection = get.KfCorrection(obj)
            %get.KfCorrection Get the value for property KfCorrection
            kfcorrection = double(obj.JavaMessage.getKfCorrection);
        end
        
        function set.KfCorrection(obj, kfcorrection)
            %set.KfCorrection Set the value for property KfCorrection
            validateattributes(kfcorrection, {'numeric'}, {'nonempty', 'scalar'}, 'Corrections', 'KfCorrection');
            
            obj.JavaMessage.setKfCorrection(kfcorrection);
        end
        
        function anglecorrections = get.AngleCorrections(obj)
            %get.AngleCorrections Get the value for property AngleCorrections
            javaArray = obj.JavaMessage.getAngleCorrections;
            array = obj.readJavaArray(javaArray, 'double');
            anglecorrections = double(array);
        end
        
        function set.AngleCorrections(obj, anglecorrections)
            %set.AngleCorrections Set the value for property AngleCorrections
            validateattributes(anglecorrections, {'numeric'}, {'vector', 'numel', 2}, 'Corrections', 'AngleCorrections');
            
            javaArray = obj.JavaMessage.getAngleCorrections;
            array = obj.writeJavaArray(anglecorrections, javaArray, 'double');
            obj.JavaMessage.setAngleCorrections(array);
        end
    end
    
    methods (Access = protected)
        function cpObj = copyElement(obj)
            %copyElement Implements deep copy behavior for message
            
            % Call default copy method for shallow copy
            cpObj = copyElement@ros.Message(obj);
            
            % Create a new Java message object
            cpObj.JavaMessage = obj.createNewJavaMessage;
            
            % Iterate over all primitive properties
            cpObj.KfCorrection = obj.KfCorrection;
            cpObj.AngleCorrections = obj.AngleCorrections;
        end
        
        function reload(obj, strObj)
            %reload Called by loadobj to assign properties
            obj.KfCorrection = strObj.KfCorrection;
            obj.AngleCorrections = strObj.AngleCorrections;
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
            
            strObj.KfCorrection = obj.KfCorrection;
            strObj.AngleCorrections = obj.AngleCorrections;
        end
    end
    
    methods (Static, Access = {?matlab.unittest.TestCase, ?ros.Message})
        function obj = loadobj(strObj)
            %loadobj Implements loading of message from MAT file
            
            % Return an empty object array if the structure element is not defined
            if isempty(strObj)
                obj = ros.custom.msggen.quadrotor_msgs.Corrections.empty(0,1);
                return
            end
            
            % Create an empty message object
            obj = ros.custom.msggen.quadrotor_msgs.Corrections;
            obj.reload(strObj);
        end
    end
end
