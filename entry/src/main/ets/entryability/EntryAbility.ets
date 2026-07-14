// entry/src/main/ets/entryability/EntryAbility.ets
import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import type Want from '@ohos.app.ability.Want';
import type LaunchParam from '@ohos.app.ability.AbilityConstant';
//import { AppStorage } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
    onCreate(want: Want, launchParam: LaunchParam.LaunchParam): void {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
        AppStorage.setOrCreate<number>("FlowBreak", 0);
        AppStorage.setOrCreate<number>("FlowWays", 0);
        AppStorage.setOrCreate<number>("Break_Count", 0);
        // ✅ 步骤1：在这里先检查并注册，越早越好
        // 如果磁盘里有值，这里不会做任何事；如果没有，就设为0
        if (!AppStorage.Has('focus_count')) {
            PersistentStorage.persistProp<number>('focus_count', 0);
            hilog.info(0x0000, 'testTag', '【初始化】首次注册 focus_count');
        } else {
            // 如果有值，打印出来看看是不是我们存的
            let val = AppStorage.Get<number>('focus_count');
            hilog.info(0x0000, 'testTag', '【读取成功】从磁盘读到的值是: %{public}d', val ?? -1);
        }
    }

    onDestroy(): void {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    }

    onWindowStageCreate(windowStage: window.WindowStage): void {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

        // ✅ 步骤2：再次确认（防御性编程）
        // 这一步是为了防止极端情况下 onCreate 没执行完
        if (!AppStorage.Has('focus_count')) {
            PersistentStorage.persistProp<number>('focus_count', 0);
        }

        windowStage.loadContent('pages/Login', (err, data) => {
            if (err.code) {
                hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
                return;
            }
            hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
        });
    }

    onWindowStageDestroy(): void {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
    }

    onForeground(): void {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
    }

    onBackground(): void {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
    }
}