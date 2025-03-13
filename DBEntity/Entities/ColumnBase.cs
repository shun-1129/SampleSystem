namespace SampleSystem.DBEntity.Entities
{
    public class ColumnBase
    {
        /// <summary>
        /// 作成日時
        /// </summary>
        public DateTime create_at { get; set; }

        /// <summary>
        /// 作成ユーザー
        /// </summary>
        public string create_user { get; set; } = string.Empty;

        /// <summary>
        /// 作成プログラム
        /// </summary>
        public string create_program { get; set; } = string.Empty;

        /// <summary>
        /// 更新日時
        /// </summary>
        public DateTime update_at { get; set; }

        /// <summary>
        /// 更新ユーザー
        /// </summary>
        public string update_user { get; set; } = string.Empty;

        /// <summary>
        /// 更新プログラム
        /// </summary>
        public string update_program { get; set; } = string.Empty;
    }
}
