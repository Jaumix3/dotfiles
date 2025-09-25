App.config({
    style: `
        window.overview {
            background: rgba(0, 0, 0, 0.85);
            color: #ffffff;
            font-family: Sans;
        }
        .title {
            font-size: 28px;
            margin: 15px;
            font-weight: bold;
        }
        .section {
            margin: 10px 0;
            padding: 5px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .workspace {
            font-size: 20px;
            margin: 5px;
            padding: 5px;
        }
        .client {
            font-size: 16px;
            margin: 4px;
            padding: 6px;
            border-radius: 6px;
            background: rgba(255,255,255,0.08);
        }
        .client:hover {
            background: rgba(255,255,255,0.2);
        }
        .client-label {
            margin-left: 5px;
        }
    `,
    windows: [
        Widget.Window({
            name: "overview",
            anchor: ["top", "left", "right", "bottom"], // fullscreen
            child: Widget.Box({
                vertical: true,
                children: [
                    Widget.Label({
                        className: "title",
                        label: "🖥️ Desktop Overview",
                    }),

                    Widget.Box({
                        vertical: true,
                        className: "section",
                        children: [
                            Widget.Label({ className: "title", label: "📌 Workspaces" }),
                            ...JSON.parse(Utils.exec("hyprctl workspaces -j")).map(ws =>
                                Widget.Label({
                                    className: "workspace",
                                    label: `Workspace ${ws.id} - ${ws.windows} windows`,
                                })
                            ),
                        ],
                    }),

                    Widget.Box({
                        vertical: true,
                        className: "section",
                        children: [
                            Widget.Label({ className: "title", label: "📂 Windows" }),
                            ...JSON.parse(Utils.exec("hyprctl clients -j")).map(c =>
                                Widget.Button({
                                    className: "client",
                                    onClicked: () =>
                                        Utils.exec(`hyprctl dispatch focuswindow address:${c.address}`),
                                    child: Widget.Label({
                                        className: "client-label",
                                        label: `[WS${c.workspace.id}] ${c.class} - ${c.title}`,
                                    }),
                                })
                            ),
                        ],
                    }),
                ],
            }),
        }),
    ],
});
