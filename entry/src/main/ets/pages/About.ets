// import router from '@ohos.router';
// import type { common, Want } from '@kit.AbilityKit';
// import { BusinessError } from '@kit.BasicServicesKit';
// import { commentManager } from '@kit.AppGalleryKit';
// import promptAction from '@ohos.promptAction';
//
// @Entry
// @Component
// struct About {
//     private uiContext: common.UIAbilityContext | null = null;
//
//     aboutToAppear() {
//         this.uiContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
//     }
//
//     // 拦截系统返回按键/侧滑返回
//     onBackPress(): boolean {
//         router.back();
//         return true;
//     }
//
//     build() {
//         Scroll() {
//             Column() {
//                 // 顶部导航栏
//                 Row() {
//                     Image($r('sys.media.ohos_ic_public_arrow_left'))
//                         .width(28)
//                         .height(28)
//                         .onClick(() => {
//                             router.back()
//                         })
//                     Text("Bug反馈")
//                         .fontSize(22)
//                         .fontWeight(FontWeight.Medium)
//                         .layoutWeight(1)
//                         .textAlign(TextAlign.Center)
//                         .fontColor('#ff000000')
//                     Blank().width(28)
//                 }
//                 .width('100%')
//                 .padding({
//                     left: 16,
//                     right: 16,
//                     top: 16,
//                     bottom: 12
//                 })
//
//                 Divider().width('100%').height(1).backgroundColor('#eee')
//
//                 Blank().height(48)
//                 // App图标
//                 Image($r('app.media.icon'))
//                     .width(140)
//                     .height(140)
//                     .borderRadius(28)
//                 Blank().height(24)
//
//                 // App名称
//                 Text("FlowClock 专注时钟")
//                     .fontSize(32)
//                     .fontWeight(FontWeight.Bold)
//                     .fontColor('#ff000000')
//                 Blank().height(8)
//                 Text("version 1.0.0")
//                     .fontSize(16)
//                     .fontColor('#ff666666')
//
//                 Blank().height(48)
//                 // 介绍文本（左对齐，匹配截图排版，不再居中）
//                 Text("一款简洁清新的专注计时开源App，帮助你专注学习、高效工作，远离手机干扰。")
//                     .fontSize(18)
//                     .fontColor('#ff333333')
//                     .padding({ left: 32, right: 32 })
//                     .textAlign(TextAlign.Start)
//                     .lineHeight(32)
//
//                 Blank().height(32)
//                 Text("由于此应用为SwiftUI语言移植应用，所以可能会出现错误，请给我们机会，我们会慢慢改正。本应用除系统内置图标外均来自Icons8")
//                     .fontSize(16)
//                     .fontColor('#ff333333')
//                     .padding({ left: 32, right: 32 })
//                     .textAlign(TextAlign.Start)
//                     .lineHeight(28)
//
//                 Blank().height(80)
//             }
//             .width('100%')
//             .backgroundColor('#ffffffff')
//         }
//         .width('100%')
//         .height('100%')
//         .backgroundColor('#ffffffff')
//         .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
//     }
// }

import router from '@ohos.router';
import type { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Bug {
    private uiContext: common.UIAbilityContext | null = null;

    aboutToAppear() {
        this.uiContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
    }

    onBackPress(): boolean {
        router.back();
        return true;
    }

    build() {
        //【改动1：外层用固定全屏Column，不再让Scroll占满屏幕】
        Column() {
            // 1. 固定顶部导航栏：脱离Scroll，永远贴页面最上方，不会产生空白
            Row() {
                Image($r('sys.media.ohos_ic_public_arrow_left'))
                    .width(28)
                    .height(28)
                    .onClick(() => {
                        router.back()
                    })
                Text("关于专注时钟")
                    .fontSize(22)
                    .fontWeight(FontWeight.Medium)
                    .layoutWeight(1)
                    .textAlign(TextAlign.Center)
                    .fontColor('#ff000000')
                Blank().width(28)
            }
            .width('100%')
            .padding({
                left: 16,
                right: 16,
                top: 16,
                bottom: 12
            })

            Divider().width('100%').height(1).backgroundColor('#eee')

            Scroll() {
                Column() {
                    Image($r('app.media.icon'))
                        .width(140)
                        .height(140)
                        .borderRadius(28)
                    Blank().height(24)

                    // App名称
                    Text("FlowClock 专注时钟")
                        .fontSize(32)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#ff000000')
                    Blank().height(8)
                    Text("version 1.0.0")
                        .fontSize(16)
                        .fontColor('#ff666666')

                    Blank().height(48)
                    // 介绍文本（左对齐，匹配截图排版，不再居中）
                    Text("一款简洁清新的专注计时开源App，帮助你专注学习、高效工作，远离手机干扰。")
                        .fontSize(18)
                        .fontColor('#ff333333')
                        .padding({ left: 32, right: 32 })
                        .textAlign(TextAlign.Start)
                        .lineHeight(32)

                    Blank().height(32)
                    Text("由于此应用为SwiftUI语言移植应用，所以可能会出现错误，请给我们机会，我们会慢慢改正。本应用除系统内置图标外均来自Icons8")
                        .fontSize(16)
                        .fontColor('#ff333333')
                        .padding({ left: 32, right: 32 })
                        .textAlign(TextAlign.Start)
                        .lineHeight(28)
                    Blank().height(40)
                }
                .width('100%')
                .backgroundColor('#ffffff')
            }
            .layoutWeight(1)
            .backgroundColor('#ffffffff')
            .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#ffffff')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
}