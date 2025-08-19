import plotly.express as px
import pandas as pd
import sys

csvfile=sys.argv[1]
print(csvfile)

df = pd.read_csv(csvfile)

df.dropna(
    axis=0,
    how='any',
    # thresh=None,
    subset=None,
    inplace=True
)

# color_scale = [(0, 'orange'), (1,'red')]

fig = px.scatter_map(df,
                        lat="Lat",
                        lon="Long",
                        hover_name="Address",
                        hover_data=["Address"],
                        # color="Listed",
                        # color_continuous_scale=color_scale,
                        # size="Listed",
                        zoom=5,
                        height=800,
                        width=800,
                        title=csvfile)

fig.update_layout(mapbox_style="open-street-map")
fig.update_layout(margin={"r":0,"t":40,"l":0,"b":0})
fig.show()
