/*
 * Copyright (C) 2024. Huawei Device Co., Ltd. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the Apache-2.0 license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * Apache-2.0 license for more details.
 */

import { ExtWeb, PageModelController } from 'WebSceneKitHsp';
import { GlobalRouter } from 'WebSceneKitHsp/src/main/ets/webrouterservice/globalrouter/GlobalRouter';
import router from '@ohos.router';

interface routerParam {
  url: string
}

@Builder
export function PageOneBuilder(name: string, param: object) {
  NativePage()
}

@Entry
@Component
export struct NativePage {
  @StorageLink('isOnForeground') isOnForeground: boolean = true;
  @State navPathStack: NavPathStack | undefined = undefined;
  url: string = "";
  aboutToAppear() {
    if (router.getParams()) {
      this.url = (router.getParams() as routerParam).url;
    }
    this.navPathStack = new NavPathStack();
    PageModelController.getInstance().addToPageStackArray(this.navPathStack);
  }

  onBackPress(): boolean | void {
    return GlobalRouter.getInstance().onBackPress(1, true, 0);
  }

  build() {
    NavDestination() {
      Column() {
        Button("NativePage")
          .width('100%')
          .fontWeight(FontWeight.Bold)
        Button("跳转NativePage1，无预渲染")
          .width('100%')
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.pushUrl({
              url: 'Pages/NativePage1'
            })
          })
        ExtWeb({ url: "resource://rawfile/frameworkTest_web/pages/mixPage1/entry.html", asMixWeb: true, isOnForeground: this.isOnForeground }).height('30%')
      }.height('100%')
    }
  }
}
