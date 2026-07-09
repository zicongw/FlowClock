//Login.ets

import router from '@ohos.router';
import common from '@ohos.app.ability.common';
import { DataController, User } from '../model/UserModel';

@Entry
@Component
struct Login {
    // --- 状态变量 ---
    @State username: string = '';
    @State password: string = '';
    @State isRegisterMode: boolean = false; // false=登录模式, true=注册模式
    @State message: string = '';
    @State isLoading: boolean = false;     // 防止重复点击
    @State isDataReady: boolean = false;   // 标记数据是否初始化完成

    // --- 生命周期 ---
    aboutToAppear() {
        try {
            let context = getContext(this) as common.UIAbilityContext;
            // 初始化控制器
            DataController.getInstance().init(context);
            this.isDataReady = true; // 标记为就绪
        } catch (e) {
            //console.error('Login Init Error: ' + JSON.stringify(e));
            this.message = '系统初始化失败';
        }
    }

    // --- 核心逻辑 ---
    async handleAuth() {
        // 1. 基础校验
        if (this.username.length < 3 || this.password.length < 6) {
            this.message = '用户名需≥3位，密码需≥6位';
            return;
        }

        // 2. 防止初始化未完成时操作
        if (!this.isDataReady) {
            this.message = '系统正在准备中，请稍候...';
            return;
        }

        this.isLoading = true;
        this.message = '';

        try {
            const controller = DataController.getInstance();
            // 获取当前存储的用户信息
            const storedUser: User | null = await controller.getCurrentUser();

            if (this.isRegisterMode) {
                // === 注册逻辑 ===
                // 检查用户是否已存在 (增加空值判断)
                if (storedUser && storedUser.username === this.username) {
                    this.message = '该用户名已被注册';
                } else {
                    let newUser = new User();
                    newUser.username = this.username;
                    newUser.password = this.password;
                    await controller.saveUser(newUser);
                    this.message = '注册成功！请登录';
                    this.isRegisterMode = false; // 自动切换回登录模式
                    this.password = ''; // 清空密码
                }
            } else {
                // === 登录逻辑 ===
                // ⚠️ 关键修复：必须判断 storedUser 是否存在
                if (storedUser &&
                    storedUser.username === this.username &&
                    storedUser.password === this.password) {
                    // 登录成功 -> 跳转主页
                    router.replaceUrl({
                        url: 'pages/Main' ,
                        params: {
                            username: this.username
                        }
                    });
                } else {
                    this.message = '用户名或密码错误';
                }
            }
        } catch (e) {
            //console.error('Auth Error: ' + JSON.stringify(e));
            this.message = '操作失败，请重试';
        } finally {
            this.isLoading = false;
        }
    }

    // --- UI 构建 ---
    build() {
        Column() {
            // 标题
            Text(this.isRegisterMode ? '创建新账户' : '欢迎回来')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 40 })

            // 用户名输入框
            TextInput({ placeholder: '请输入用户名(不少于3字符)', text: this.username })
                .width('85%')
                .height(50)
                .backgroundColor('#F5F5F5')
                .borderRadius(12)
                .padding({ left: 15 })
                .onChange((value: string) => { this.username = value })
                .margin({ bottom: 20 })

            // 密码输入框
            TextInput({ placeholder: '请输入密码(不少于6字符)', text: this.password })
                .type(InputType.Password)
                .width('85%')
                .height(50)
                .backgroundColor('#F5F5F5')
                .borderRadius(12)
                .padding({ left: 15 })
                .onChange((value: string) => { this.password = value })
                .margin({ bottom: 10 })

            // 提示信息
            Text(this.message)
                .fontSize(14)
                .fontColor(Color.Red)
                .margin({ bottom: 20 })
                .textAlign(TextAlign.Center)
                .width('85%')

            // 提交按钮
            Button(this.isLoading ? '处理中...' : (this.isRegisterMode ? '立即注册' : '登 录'))
                .width('85%')
                .height(50)
                .borderRadius(25)
                .enabled(!this.isLoading) // 加载中禁用按钮
                .backgroundColor("#ff4ca46d")
                .onClick(() => { this.handleAuth() })
                .margin({ bottom: 20 })

            // 切换模式文本
            Text(this.isRegisterMode ? '已有账号？去登录' : '没有账号？免手机号注册')
                .fontSize(14)
                .fontColor('#666666')
                .onClick(() => {
                    this.isRegisterMode = !this.isRegisterMode;
                    this.message = '';
                    this.password = '';
                })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center) // 垂直居中
        .linearGradient({
            angle: 160, // 倾斜角度，更有动感
            colors: [
                ['#ffe9eff5', 0.0], // 顶部：极淡的青蓝色（像天空）
                ['#ffeef8ef', 0.5], // 中间：淡薄荷绿
                ['#ffd0f3d1', 1.0]  // 底部：稍深的嫩绿
            ]
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
}

// 预览组件
@Preview
@Component
struct LoginPreview {
    build() {
        Login()
    }
}