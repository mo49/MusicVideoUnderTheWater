Shader "Custom/Gradation" {
	Properties{
		_Color("Color", Color) = (1, 1, 1, 1)
		_Displacement("Displacement", float) = 1
	}
		SubShader{
			Tags { "RenderType" = "Transparent" }
			Cull Off ZWrite On Blend SrcAlpha OneMinusSrcAlpha
			Pass {
				CGPROGRAM

				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				struct v2f {
					float4 pos : SV_POSITION;
					float3 worldPos : TEXCOORD0;
				};

				float4 _Color;
				float _Displacement;
				uniform float _SPosAry[256];

				v2f vert(appdata_base v)
				{
					v2f o;
					float3 n = UnityObjectToWorldNormal(v.normal);
					// move position forward vertex
					//o.pos = UnityObjectToClipPos(v.vertex) + float4(n * _SinTime.z * _Displacement, 0);

					// 1マス10　x:-50~50 (画角に入っているのは-30~30くらい) 
					// 傾き＝(255/2) / 画角
					o.pos = UnityObjectToClipPos(v.vertex + v.normal * _SPosAry[clamp((v.vertex.x) * (255/2)/30 +(255/2), 0, 255)] * _Displacement);

					//o.pos = UnityObjectToClipPos(v.vertex + v.normal * _SPosAry[clamp((v.vertex.y) * (255/20), 0, 255)] * _Displacement);
					o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

					return o;
				}

				half4 frag(v2f i) : COLOR
				{
					float4 red = float4(255.0 / 255,70.0 / 255,150.0 / 255,1);
					float4 blue = float4(90.0 / 255,90.0 / 255,250.0 / 255,1);
					return lerp(red, blue, i.worldPos.y * 0.5 * _SinTime.z);
				}
				ENDCG
			}
	}
		FallBack Off
}