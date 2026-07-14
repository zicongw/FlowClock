// common/Storage.ets
import preferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

let dataPref: preferences.Preferences | null = null;

// 仅首次初始化，重复调用直接返回
export async function initStorage(ctx: common.UIAbilityContext) {
    if (dataPref !== null) return;
    dataPref = await preferences.getPreferences(ctx, "flow_storage");
}

// 获取Number_Flow，默认0
export async function getNumberFlow(): Promise<number> {
    if (!dataPref) return 0;
    // 强制从磁盘读取，不走内存缓存
    return dataPref.getSync("Number_Flow", 0) as number;
}

// 设置Number_Flow
export async function setNumberFlow(val: number) {
    if (!dataPref) return;
    await dataPref.put("Number_Flow", val);
    await dataPref.flush(); // 强制落盘
}

// 自增1
export async function addNumberFlow() {
    const curr = await getNumberFlow();
    await setNumberFlow(curr + 1);
}

// 清空数值
export async function clearNumberFlow() {
    if (!dataPref) return;
    await dataPref.delete("Number_Flow");
    await dataPref.flush();
}