//显示信息,tips:信息内容；height:设置top距离;time:延时多长时间;
function showTips(tips, height, time) {
    var windowWidth = document.body.clientWidth;
    var tipsDiv = '<div class="tipsClass">' + tips + '</div>';
    $('.tipsClass').remove();
    $('body').append(tipsDiv);
    $('div.tipsClass').css({
        'top' : height + 'px',
        'position' : 'absolute',
        'background' : 'rgb(158, 158, 158)',
        'font-size' : 16 + 'px',
        'margin' : '0 auto',
        'text-align' : 'center',
        'width' : windowWidth + 'px',
        'line-height' : '50px',
        'height' : '50px',
        'color' : '#fff',
        'opacity' : '1'
    }).show();
    setTimeout(function() {
        $('div.tipsClass').fadeOut();
    }, (time * 1000));
}