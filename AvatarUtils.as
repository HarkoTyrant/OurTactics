Object.prototype.clone = function() {
	/*myObject=new Object()
	myObject.name="Arul";
	myObject.gender="Male";
	myObject.age=29;
	copyObject=myObject.clone();*/
        if (this instanceof Array) {
                var to = [];
                for (var i = 0; i<this.length; i++) {
                        to[i] = (typeof (this[i]) == "object") ? this[i].clone() : this[i];
                }
		}else if (this instanceof XML || this instanceof MovieClip) {
                // can't clone this so return null
                var to = null;
                trace("Warning! Object.clone can not be used on MovieClip or XML objects");
        } else {
                var to = {};
                for (var i in this) {
                        to[i] = (typeof (this[i]) == "object") ? this[i].clone() : this[i];
                }
        }
        return to;
};
ASSetPropFlags(Object.prototype, ["clone"], 1);
