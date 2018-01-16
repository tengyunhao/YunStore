/*==========登录方式的切换=============*/
//登录切换元素的父元素
var regTop=document.getElementById('reg-top');
//获取普通登录元素
var normal=document.getElementById('normal');
//alert(normal);
//获取无密码登录元素
var nopw=document.getElementById('nopw');
//获取扫码登录元素
var saoma=document.getElementById('qrcode');
//获取PC登录元素
var screen=document.getElementById('screen');

//获取普通登录对应的div
var rc=document.getElementById('rc');
//获取无密码登录对应的div
var lc=document.getElementById('lc');
//获取扫码登录对应的div
var sm=document.getElementById('sm');

//登录状态标识位
var rcFlag=true;
var lcFlag=false;

//实现登录方式的切换
normal.onclick=function(){
    rc.style.display="block";
    lc.style.display="none";
    sm.style.display="none";
    regTop.style.display="block";
    nopw.style.borderBottom="none";
    normal.style.borderBottom="2px solid #00a6ff";
    rcFlag=true;
    lcFlag=false;

}

nopw.onclick=function(){
    rc.style.display="none";
    lc.style.display="block";
    sm.style.display="none";
    regTop.style.display="block";
    nopw.style.borderBottom="2px solid #00a6ff";
    normal.style.borderBottom="none";
    rcFlag=false;
    lcFlag=true;
}

saoma.onclick=function(){
    rc.style.display="none";
    lc.style.display="none";
    sm.style.display="block";
    regTop.style.display="none";
}
screen.onclick=function(){
    regTop.style.display="block";
    sm.style.display="none";
    if(rcFlag){
        rc.style.display="block";
        return;
    }else{
        rc.style.display="none";
    }
    if(lcFlag){
        lc.style.display="block";
        return;
    }else{
        lc.style.display="none";
    }
}

/*=========普通登录表单验证============*/
//获取提示框元素
var rcInnerNum=document.getElementById('rc-inner-num');
var rcinnerText=rcInnerNum.getElementsByTagName('span')[0];


var rcInnerVirity=document.getElementById('rc-inner-virity');
var rcInnerVirityText=rcInnerVirity.getElementsByTagName('span')[0];

//手机号码输入框
var inputPhone=document.getElementsByName('phone-num')[0];
//alert(inputPhone);
//密码输入框
var inputPassword=document.getElementsByName('password')[0];
//获取登录按钮
var loginBtn=document.getElementById('login-btn');


//用户名输入框验证
//手机输入正确标识位
var nFlag=false;
inputPhone.onblur=function(){
    //手机号码的正则验证
    var reg=/^(1([358][0-9]|(47)|[7][0178]))[0-9]{8}$/;
    //console.log(this.value);
    if(this.value==""){
        rcInnerNum.style.display="block";
        rcInnerVirity.style.display="none";
        return;
    }
    if(reg.test(this.value)){
        return;
    }else{
        rcInnerNum.style.display="block";
        rcInnerVirity.style.display="none";
    }
}

inputPhone.onfocus=function(){
    rcInnerNum.style.display="none";
    $('.success').hide();
    $('#rc-innerError').eq(0).hide();
}

//密码输入框验证
var passFlag=false;
inputPassword.onblur=function(){
    if(this.value==""){
        if(nFlag){
            rcInnerVirity.style.display="block";
            rcInnerNum.style.display="none";
            rcInnerVirityText.innerText="请输入密码";
        }
        return;
    }
    var reg=/((?=.*[a-z])(?=.*\d)|(?=[a-z])(?=.*[#@!~%^&*])|(?=.*\d)(?=.*[#@!~%^&*]))[a-z\d#@!~%^&*]{5,15}/i;
    //*密码必须为8-16位<br/>*必须有字母、数字或特殊字符其中两种
    if(!reg.test(this.value)){
        rcInnerVirity.style.display="block";
        rcInnerVirityText.innerText="密码为8-16位的字母或数字或特殊字符的结合";
        rcInnerNum.style.display="none";
    }else{
        passFlag=true;
        return;
    }
}

inputPassword.onfocus=function(){
    rcInnerVirity.style.display="none";
    $('#rc-innerError').eq(0).hide();
}

//按钮验证
loginBtn.onclick=function(e){
    stopDefault(e);
    if(inputPhone.value==""){
        rcInnerNum.style.display="block";
        rcinnerText.innerText="请输入昵称/邮箱/手机号码";
        rcInnerVirity.style.display="none";
        return;
    }
    if(inputPassword.value==""){
        if(nFlag){
            rcInnerVirity.style.display="block";
            rcInnerNum.style.display="none";
        }
        return;
    }
    if(passFlag&&nFlag){
        var phone = inputPhone.value;
        var pass = inputPassword.value;
        /*console.log(phone);
        console.log(pass);*/
        $.post('./js/validate.php',{phone:phone,pass:pass},function(data){
            if(data=='0'){
                $('#rc-innerError').eq(0).show();
            }else{
                window.location.href='../main/index.html';
            }
        });
    }
}


/*=========手机无密码登录=============*/
//获取手机号码提示框元素
var innerNum=document.getElementById('inner-num');
var innerNumText=innerNum.getElementsByTagName('span')[0];
//获取密码提示框元素
var innerVirity=document.getElementById('inner-virity');
var innerVirityText=innerVirity.getElementsByTagName('span')[0];


//获取下拉列表元素
var selectList=document.getElementById('country');
//获取手机号码输入框
var noPhoneNum=document.getElementsByName('phone-num')[1];
//console.log(noPhoneNum);
//获取密码输入框
var otp=document.getElementsByName('password')[1];
//获取手机动态密码按钮
var getcodeBtn=document.getElementById('getcode');
//登录按钮
var loginBtn1=document.getElementById('login-btn1');

var country=[
    '其他'
];

//循环创建下拉列表项
for(var i=0;i<country.length;i++){
    var option=document.createElement('option');
    option.innerText=country[i];
    selectList.appendChild(option);
}

//手机号码验证
var npnFlag=false;
noPhoneNum.onblur=function(){
    var reg=/^(1([358][0-9]|(47)|[7][0178]))[0-9]{8}$/;
    if(this.value==""){
        innerNum.style.display="block";
        innerNumText.innerText="请输入手机号码";
        innerVirity.style.display="none";
        return;
    }
    if(!reg.test(this.value)){
        innerNum.style.display="block";
        innerNumText.innerText="请输入正确的手机号码";
        innerVirity.style.display="none";
        return;
    }else{
        var value=$(this).val();
        $.post('./js/login.php',{phone:value},function(data){
            //console.log(data);
            if(data=='0'){
                $('#inner-num').show().text();
                $('#inner-virity').hide();
                $('#inner-num > span').text('手机号码不存在,请重新输入！');
            }else{
                $('.success').show();
                npnFlag=true;
            }
        });
        return;
    }
}

noPhoneNum.onfocus=function(){
    innerNum.style.display="none";
    $('.success').hide();
}

//动态密码验证
var otpFlag=false;
otp.onblur=function(){
    var reg=/^\d{6}$/;
    if(this.value==""){
        if(npnFlag){
            innerVirity.style.display="block";
            innerVirityText.innerText="请输入验证码";
            innerNum.style.display="none";
        }
        return;
    }
    if(!reg.test(this.value)){
        if(npnFlag){
            innerVirity.style.display="block";
            innerVirityText.innerText="验证码为6位数字";
            innerNum.style.display="none";
        }
    }else{
        otpFlag=true;
        return;
    }
}

otp.onfocus=function(){
    innerVirity.style.display="none";
}

//获取动态密码按钮验证
getcodeBtn.onclick=function(e){
    stopDefault(e);
    if(npnFlag){

    }else{
        innerNum.style.display="block";
        innerNumText.innerText="请输入手机号码";
        innerVirity.style.display="none";
        return;
    }
}

//登录按钮验证
loginBtn1.onclick=function(e){
    stopDefault(e);
    if(noPhoneNum.value==""){
        innerNum.style.display="block";
        innerNumText.innerText="请输入手机号码";
        innerVirity.style.display="none";
        return;
    }
    if(otp.value==""){
        if(npnFlag){
            innerVirity.style.display="block";
            innerVirityText.innerText="请输入验证码";
            innerNum.style.display="none";
        }
        return;
    }
    if(npnFlag&&otpFlag){
        //数据提交，及登录跳转
        window.location.href='../main/index.html';
    }

}


//阻止按钮默认提交的行为函数
function stopDefault(e)
{
    if (e&&e.preventDefault)
    {
        e.preventDefault();//非IE
    }
    else
    {
        window.event.returnValue = false;//IE
        return false;
    }
}