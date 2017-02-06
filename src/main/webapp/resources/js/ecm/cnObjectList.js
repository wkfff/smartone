function spf_object_initGrid(gridId,objectCategory,changeNo){
    	var grid = $("#"+gridId).ligerGrid({
    		columns: [
			            { display: '', name: 'OBJECT_ID', width: 0,hide: 1},
			            { display: '', name: 'OBJECT_CATEGORY', width: 0,hide: 1, render: function(){
			            	return objectCategory;
			            	}
			            },
						{ display: '名称', name: 'OBJECT_NAME', width: 180},
						{ display: '状态', name: 'STATUS_NAME', width: 120},
						{ display: '是否包含', name: 'IS_INCLUDED', width: 90,
							render:function(item){
								if(item.IS_INCLUDED=='0'){
									return '<img src="/resources/images/notuse.png">';
								}
								if(item.IS_INCLUDED=='1'){
									return '<img src="/resources/images/inuse.png">';
								}
							}
						},
						{ display: '是否已修改', name: 'IS_UPDATED', width: 90,
							render:function(item){
								if(item.IS_UPDATED=='0' || item.IS_UPDATED==null){
									return '否';//'<img src="/resources/images/notuse.png">';
								}
								if(item.IS_UPDATED=='1'){
									return '是';//'<img src="/resources/images/inuse.png">';
								}
							}
						},
						{ display: '描述', name: 'DESCRIPTION', width: 220}
		            ],
		    //checkbox:true,        
            rownumbers:true,
            resizable:false,
            usePager:true,
            fixedCellHeight:true,
            url: '/ecm/cnInfo/getObjectList',
            parms: [
                     { name: 'CHANGE_NO', value: changeNo},
                     { name: 'LIMIT', value: 'INCLUDE'},
                     { name: 'OBJECT_CATEGORY', value: objectCategory}
                   ],
            width: '99.6%', height: '100%'
        });
    	return grid;
    }
