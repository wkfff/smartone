/*! 
html5 javascript helper 
http://www.ikende.com 
license Apache License 2.0 (Apache)
*/
function TcpChannel() {
    this.Connected = null;
    this.Error = null;
    this.Receive = null;
    this.Socket = null;
    this.ActionID = 0;
    this.Disposed = null;
    this.CallBacks = new Object();
    
}

TcpChannel.prototype.Send = function (data,  callback) {
    if (this.ActionID > 500) {
        this.ActionID = 0;
    }
    this.ActionID++;
    var obj = new Object();
    obj.url = data.url;
    obj.actionid = this.ActionID;
    obj.parameters = data.parameters;
    this.CallBacks[this.ActionID.toString()] == null;
    if (callback != null) {
        this.CallBacks[this.ActionID.toString()] = callback;

    }

    var datastr = JSON.stringify(obj);
    
    this.Socket.send(datastr);
}
TcpChannel.prototype.Close = function () {
    Socket.close();
}

TcpChannel.prototype.OnReceive = function (data) {
   
    var obj = JSON.parse(data)


    var actionid = obj.actionid.toString();
    var callback = this.CallBacks[actionid.toString()];

    if (callback != null) {
        callback(obj);
    }
    else {
        if (this.Receive != null) {
            this.Receive(obj);
        }
    }
}

TcpChannel.prototype.Connect = function (wsUri) {
    var channel = this;
    this.Socket = new WebSocket(wsUri);
    this.Socket.onopen = function (evt) {
       
        if (channel.Connected != null)
            channel.Connected(evt);
    };
    this.Socket.onclose = function (evt) {
        if (channel.Disposed != null)
            channel.Disposed(evt);
    };
    this.Socket.onmessage = function (evt) {
        channel.OnReceive(evt.data.toString());
    };
    this.Socket.onerror = function (evt) {
        if (channel.Error != null)
            channel.Error(evt);
    };
}
function FileInfo(file, pagesize) {
    this.Size = file.size;
    this.File = file;
    this.FileType = file.type;
    this.FileName = file.name;
    this.PageSize = pagesize;
    this.PageIndex = 0;
    this.Pages = 0;
    this.DataBuffer = null;
    this.LoadCallBack = null;
    if (Math.floor(this.Size % this.PageSize)>0) {
        this.Pages = Math.floor((this.Size / this.PageSize))+1;
       
    }
    else {
        this.Pages = Math.floor(this.Size / this.PageSize);
       
    }

}
FileInfo.prototype.toBase64String = function () {
    var binary = ''
    var bytes = new Uint8Array(this.DataBuffer)
    var len = bytes.byteLength;
    for (var i = 0; i < len; i++) {
        binary += String.fromCharCode(bytes[i])
    }
    return window.btoa(binary);
}
FileInfo.prototype.OnLoadData = function (evt) {
    var obj = evt.target["tag"];
  
    if (evt.target.readyState == FileReader.DONE) {
        obj.DataBuffer = evt.target.result;
    }

    if (obj.LoadCallBack != null)
        obj.LoadCallBack(this);

}
FileInfo.prototype.Load = function (completed) {
    this.LoadCallBack = completed;
    var reader = new FileReader();
    reader["tag"] = this;  
    reader.onloadend = this.OnLoadData;
    var count = this.Size - this.PageIndex * this.PageSize;
    if (count > this.PageSize)
        count = this.PageSize;
    var blob = this.File.slice(this.PageIndex * this.PageSize, count);
    reader.readAsArrayBuffer(blob);
};
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};