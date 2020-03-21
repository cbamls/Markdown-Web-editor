var IndexedDb=function (dbname,connCallback,connectionVersion) {
    var that = this;
    void 0 === connectionVersion && (connectionVersion = 1)
    // In the following line, you should include the prefixes of implementations you want to test.
    window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    // DON'T use "var indexedDB = ..." if you're not in a function.
    // Moreover, you may need references to some window.IDB* objects:
    window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
    window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange
    // (Mozilla has never prefixed these objects, so we don't need window.mozIDB*)
    this.databaseName=dbname;
    if (!window.indexedDB) {
        console.info("Your browser dons't support IndexedDB");
        return;
    }
    this.connection = window.indexedDB.open(dbname, connectionVersion);
    this.connection.onerror = function (e) {
        if(void 0 === connCallback.abort) {
            console.error(e.target.error);
        }else{
            connCallback.connError(e);
        }
    }
    this.connection.onupgradeneeded = function (e) {
        console.info("Upgrading");
        that.db = e.target.result;
        connCallback.connUpgrade(that,e);
    }
    this.connection.onsuccess = function (e) {
        console.info("open indexed db success");
        that.db = e.target.result;
        connCallback.connSuccess(that,e);
    }
}
IndexedDb.prototype.createTable=function (tableName,keyPath,callback) {
    var objectStore = this.db.createObjectStore(tableName, {keyPath: keyPath});
    if(void 0 === callback || void 0 === callback.success){
        console.info("create success");
    }else{
        callback.success(objectStore);
    }
}
IndexedDb.prototype.deleteTable=function (tableName) {
    this.db.deleteObjectStore(tableName);
}
IndexedDb.prototype.add=function (storeName,data,callback) {
    var transaction=this.db.transaction([storeName],"readwrite");
    var objectStore=transaction.objectStore(storeName);
    var request=objectStore.add(data);
    request.onsuccess=function (e) {
        if(void 0 === callback || void 0 === callback.success){
            console.info("add success")
        }else{
            callback.success(e);
        }

    }
    transaction.oncomplete=function (e) {
        if(void 0 === callback || void 0 === callback.complete){
            console.info("add complete");
        }else{
            callback.complete(e);
        }
    }
    transaction.onerror=function (e) {
        if(void 0 === callback || void 0 === callback.error){
            console.error(e.target.error);
        }else{
            callback.error(e);
        }
    }
}
IndexedDb.prototype.delete=function (storeName,keyPath,callback) {
    var transaction=this.db.transaction([storeName],"readwrite");
    var objectStore=transaction.objectStore(storeName);

    var request=objectStore.delete(keyPath);
    request.onsuccess=function (e) {
        if(void 0 === callback || void 0 === callback.success){
            console.info("delete success")
        }else{
            callback.success();
        }

    }
    transaction.oncomplete=function (e) {
        if(void 0 === callback || void 0 === callback.complete){
            console.info("delete complete");
        }else{
            callback.complete(e);
        }
    }
    transaction.onerror=function (e) {
        if(void 0 === callback || void 0 === callback.error){
            console.error(e.target.error);
        }else{
            callback.error(e);
        }
    }
}
IndexedDb.prototype.get=function (storeName,keyPath,callback) {
    var transaction=this.db.transaction([storeName],"readonly");
    var objectStore=transaction.objectStore(storeName);
    var request=objectStore.get(keyPath);
    request.onsuccess=function (e) {
        if(void 0 === callback || void 0 === callback.success){
            console.error(e.target.error);
        }else{
            callback.success(request.result);
        }

    }
    transaction.oncomplete=function (e) {
        if(void 0 === callback || void 0 === callback.complete){
            console.info("get complete");
        }else{
            callback.complete(e);
        }
    }
    transaction.onerror=function (e) {
        if(void 0 === callback || void 0 === callback.error){
            console.error(e.target.error);
        }else{
            callback.error(e);
        }
    }
}
IndexedDb.prototype.set=function (storeName,keyPath,key,value,callback) {
    var transaction = this.db.transaction([storeName], "readwrite");
    var objectStore = transaction.objectStore(storeName);
    var request = objectStore.get(keyPath);
    request.onsuccess = function (e) {
        request.result[key] = value;
        objectStore.put(request.result);
        if (void 0 === callback || void 0 === callback.success) {
            console.info("put success");
        } else {
            callback.success();
        }
    }
    transaction.oncomplete = function (e) {
        if (void 0 === callback || void 0 === callback.complete) {
            console.info("set complete");
        } else {
            callback.complete(e);
        }
    }
    transaction.onerror = function (e) {
        if(void 0 === callback || void 0 === callback.error){
            console.error(e.target.error);
        }else{
            callback.error(e);
        }

    }
}
IndexedDb.prototype.close=function () {
    this.db.close();
}
IndexedDb.prototype.deleteDatabase=function (DbName) {
    this.close();
    if(DbName==this.databaseName) {
        window.indexedDB.deleteDatabase(DbName);
    }else{
        console.error("database name don't match,delete fail")
    }
}
var Cookie= function(){}
Cookie.prototype.get=function (name) {
    var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));

    if (arr != null)
        return unescape(arr[2]);

    return null;
}

Cookie.prototype.set=function (name, val) {
    var days = 30;
    var date = new Date();
    date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(val) + ";expires=" + date.toGMTString();
}

Cookie.prototype.delete=function (name) {
    document.cookie = name + "=;expires=-1";
}