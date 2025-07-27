
Shader "LuizZz/Invertion Inverting 1.0" {
Properties 
{
    _Color ("Tint Color", Color) = (1,1,1,1)
    _MainTex ("Texture", 2D) = "white" {}  
    [Enum(Off,0,Front,1,Back,2)] _Cull ("Cull Mode", Float) = 0
}

SubShader 
{
    Tags { "Queue"="Transparent" }

    Pass
    {
        ZWrite On
        ColorMask 0
    }
    Blend OneMinusDstColor OneMinusSrcAlpha 
    BlendOp Add
    
    Pass
    { 
        Cull [_Cull]

        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag 
        #include "UnityCG.cginc"

        uniform float4 _Color;
        sampler2D _MainTex;                
        float4 _MainTex_ST;                

        struct vertexInput
        {
            float4 vertex: POSITION;
            float2 uv : TEXCOORD0;         
            float4 color : COLOR;	
        };

        struct fragmentInput
        {
            float4 pos : SV_POSITION;
            float2 uv : TEXCOORD0;        
            float4 color : COLOR0; 
        };

        fragmentInput vert( vertexInput i )
        {
            fragmentInput o;
            o.pos = UnityObjectToClipPos(i.vertex);
            o.uv = TRANSFORM_TEX(i.uv, _MainTex); 
            o.color = _Color;
            return o;
        }

        half4 frag( fragmentInput i ) : COLOR
        {
            half4 texColor = tex2D(_MainTex, i.uv);
            return texColor * i.color;              
        }
        ENDCG
    }
}
}
