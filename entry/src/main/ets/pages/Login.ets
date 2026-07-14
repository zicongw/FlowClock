import { DataController, User } from '../model/UserModel';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Login {
    // 文字动画状态
    @State textOpacity: number = 0
    @State textOffsetY: number = 20
    // 按钮动画状态（延迟出场）
    @State btnOpacity: number = 0
    @State btnOffsetY: number = 20

    aboutToAppear() {
        // 文字：页面加载立刻执行淡入
        setTimeout(() => {
            animateTo({ duration: 400 }, () => {
                this.textOpacity = 1
                this.textOffsetY = 0
            })
        }, 50)
        // 按钮：比文字晚300ms再淡入，错开视觉层次
        setTimeout(() => {
            animateTo({ duration: 400 }, () => {
                this.btnOpacity = 1
                this.btnOffsetY = 0
            })
        }, 350)
    }

    build() {
        Column() {
            Column() {
                Text("欢迎使用")
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#ff000000')
                    .fontSize(45)
                    //.margin({ bottom: 60 })
                Text("本应用坚持无广开源，为您带来纯粹的专注功能\n")
                    .fontSize(16)
                    .fontColor('#ff000000')
                    .margin({top: 20})
            }
            // 绑定文字独立动画
            .opacity(this.textOpacity)
            .translate({ y: this.textOffsetY })

            Button() {
                Row() {
                    Text("开启专注之旅")
                        .fontSize(25)
                        .margin({ left: 10 })
                        .fontColor('#1B5E20')
                        .fontWeight(FontWeight.Bold)
                    Image($r("app.media.right"))
                        .width(40)
                }
                .width(200)
                .height(50)
                .justifyContent(FlexAlign.Center)
            }

            .margin({top: 50})
            .backgroundColor('rgba(255, 255, 255, 0.35)')
            .border({ width: 1.5, color: 'rgba(255, 255, 255, 0.4)', radius: 24 })
            .backdropBlur(25)
            .shadow({ radius: 15, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: 8 })
            .borderRadius(20)
            // 绑定按钮独立延迟动画
            .opacity(this.btnOpacity)
            .translate({ y: this.btnOffsetY })
            .onClick(()=>{
                router.pushUrl({url: 'pages/Main'})
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
            angle: 0,
            colors: [
                ['#ffc3cedb', 0.0],
                ['#ffeeeff3', 1.0]
            ]
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
}

@Preview
@Component
struct LoginPreview {
    build() {
        Login()
    }
}