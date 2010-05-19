/**
 * JList
 * Handles List functionality
 * @author Anna Do <annahdo.com>
**/
YUI.add("JList", function(Y) {

	JList = function(config) {
		this.body = NULL;
		
		this._constructor(config);
	};
	
	JList.prototype = {

		_makeRequest: function(target, params) {
			var url = target.getAttribute('href');
			
			Y.Get.script(url, {
				onSuccess: requestSuccess,
				onFailure: requestFailure
			})
		},
		
		

		_constructor: function(config) {
			this.body = config.body;
			this.body.on('click', this.onClickHandler, this);
			
		},
		
		onClickHandler: function(e) {
			var target = e.target,
				type = e.type,
				classnames = target.get('className').split(/\s+/),
				i = classnames.length;
			
			while (i--) {
				switch (classes[i]) {
					case 'jl-check':
						this.checkItem(target);
						e.preventDefault();
						break;
					case 'jl-delete':

						break;
					default:
						break;
				}
			}
		},
		
		addItem: function() {
			// TODO
		},

		checkItem: function(target) {
			var url = target.getAttribute('href') + '?format=json';
			
			Y.io(url, {
				method: 'POST',
				onSuccess: requestSuccess,
				onFailure: requestFailure
			})
			
		},

		deleteItem: function() {

		},
		
		requestSuccess: function(id, o, args) {
			var data = o.responseText;
		},
		
		requestFailure: function(id, o) {
			// TODO
		}

	};

	Y.namespace('Y.JList');
	Y.TabList = TabList;

}, "1.0", { requires: ['event']});


